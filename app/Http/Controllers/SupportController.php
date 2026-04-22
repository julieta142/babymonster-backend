<?php

namespace App\Http\Controllers;

use App\Models\SupportMessage;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Mail\SupportMessageReceived;
use App\Mail\SupportResponseReceived;
use App\Events\NewSupportMessage;

class SupportController extends Controller
{
    public function sendMessage(Request $request)
    {
        try {
            Log::info('Support message received', $request->all());

            $validated = $request->validate([
                'email' => 'required|email',
                'subject' => 'required|string|max:255',
                'message' => 'required|string|min:10'
            ]);

            // Find the user by email
            $user = User::where('email', $validated['email'])->first();

            if (!$user) {
                return response()->json([
                    'success' => false,
                    'message' => 'User not found'
                ], 404);
            }

            // Check if user has a REJECTED message (prevent new messages)
            $hasRejected = SupportMessage::where('user_id', $user->id)
                ->where('status', 'rejected')
                ->exists();

            if ($hasRejected) {
                Log::warning('User with rejected message tried to send new message', ['user_id' => $user->id]);
                return response()->json([
                    'success' => false,
                    'message' => 'Your previous support request was rejected. You cannot submit another request.',
                    'can_send' => false
                ], 403);
            }

            // Check if user has pending message
            $hasPending = SupportMessage::where('user_id', $user->id)
                ->whereIn('status', ['pending', 'in_review'])
                ->exists();

            if ($hasPending) {
                return response()->json([
                    'success' => false,
                    'message' => 'You already have a pending support request. Please wait for response.'
                ], 400);
            }

            // Get is_from_blocked_user from request
            $isFromBlockedUser = $request->input('is_from_blocked_user', false);

            $supportMessage = SupportMessage::create([
                'user_id' => $user->id,
                'subject' => $validated['subject'],
                'message' => $validated['message'],
                'status' => 'pending',
                'is_from_blocked_user' => $isFromBlockedUser
            ]);

            $supportMessage->load('user');

            // Only notify superadmins if NOT from blocked user
            if (!$isFromBlockedUser) {
                $this->notifySuperadmins($supportMessage);
            } else {
                Log::info('Blocked user message - no email sent', ['user_id' => $user->id]);
            }

            // Broadcast event
            try {
                broadcast(new NewSupportMessage($supportMessage))->toOthers();
            } catch (\Exception $e) {
                Log::warning('Broadcast failed: ' . $e->getMessage());
            }

            $responseMessage = $isFromBlockedUser
                ? 'Your message has been received. A superadmin will review your case.'
                : 'Your message has been sent. Superadmin will review it shortly.';

            return response()->json([
                'success' => true,
                'message' => $responseMessage,
                'is_blocked' => $isFromBlockedUser
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Support message error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to send message. Please try again later.'
            ], 500);
        }
    }

    public function respondToMessage(Request $request, $id)
    {
        try {
            $request->validate([
                'response' => 'required|string|min:5',
                'status' => 'required|in:resolved,rejected',
                'rejection_reason' => 'required_if:status,rejected|nullable|string'
            ]);

            $message = SupportMessage::findOrFail($id);
            $admin = $request->user();

            $message->update([
                'admin_id' => $admin->id,
                'admin_response' => $request->response,
                'status' => $request->status,
                'rejection_reason' => $request->rejection_reason,
                'responded_at' => now()
            ]);

            $message->load('user');

            // Send email to user
            try {
                Mail::to($message->user->email)->send(new SupportResponseReceived($message));
                Log::info('Response email sent to user: ' . $message->user->email);
            } catch (\Exception $e) {
                Log::error('Failed to send response email: ' . $e->getMessage());
            }

            // Unblock user if resolved
            if ($request->status === 'resolved' && $message->user->is_blocked) {
                $message->user->update(['is_blocked' => false]);
                Log::info('User unblocked: ' . $message->user->email);
            }

            return response()->json([
                'success' => true,
                'message' => 'Response sent successfully'
            ]);

        } catch (\Exception $e) {
            Log::error('Error responding to message: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to send response'
            ], 500);
        }
    }

    private function notifySuperadmins($supportMessage)
    {
        $superadmins = User::whereHas('roles', function($query) {
            $query->where('name', 'superadmin');
        })->get();

        foreach ($superadmins as $admin) {
            try {
                Mail::to($admin->email)->send(new SupportMessageReceived($supportMessage));
                Log::info('Email sent to superadmin: ' . $admin->email);
            } catch (\Exception $e) {
                Log::error('Failed to send email to superadmin: ' . $e->getMessage());
            }
        }
    }

    // Admin methods
    public function getMessages(Request $request)
    {
        $messages = SupportMessage::with(['user', 'admin'])
            ->orderBy('created_at', 'desc')
            ->paginate(20);

        return response()->json([
            'success' => true,
            'data' => $messages
        ]);
    }

    public function getUnreadCount()
    {
        $count = SupportMessage::where('status', 'pending')
            ->whereNull('read_at')
            ->count();

        return response()->json([
            'success' => true,
            'count' => $count
        ]);
    }
}
