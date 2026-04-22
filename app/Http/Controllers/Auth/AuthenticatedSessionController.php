<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use App\Models\SupportMessage;
use Illuminate\Support\Facades\Log;

class AuthenticatedSessionController extends Controller
{
    public function store(LoginRequest $request)
    {
        $credentials = $request->only('email', 'password');
        $user = User::where('email', $credentials['email'])->first();

        if (!$user) {
            return response()->json([
                'message' => 'The provided credentials are incorrect.',
                'errors' => [
                    'email' => ['No account found with this email address.']
                ]
            ], 422);
        }

        if (!Hash::check($credentials['password'], $user->password)) {
            return response()->json([
                'message' => 'The provided credentials are incorrect.',
                'errors' => [
                    'password' => ['Incorrect password. Please try again.']
                ]
            ], 422);
        }

     if ($user->is_blocked) {
        $rejectedMessage = SupportMessage::where('user_id', $user->id)
            ->where('status', 'rejected')
            ->first();

                Log::info('Blocked user login attempt', [
        'user_id' => $user->id,
        'has_rejected_message' => $rejectedMessage ? 'yes' : 'no',
        'rejection_reason' => $rejectedMessage?->rejection_reason
    ]);

        $response = [
            'message' => 'Account blocked',
            'errors' => [
                'email' => ['Your account has been blocked. Please contact support.']
            ]
        ];

      if ($rejectedMessage && $rejectedMessage->rejection_reason) {
        $response['rejection_reason'] = $rejectedMessage->rejection_reason;
        $response['message'] = $rejectedMessage->rejection_reason;
    }


        return response()->json($response, 403);
    }

        Auth::login($user);
        $request->session()->regenerate();

        $user->load('roles');

        return response()->json([
            'success' => true,
            'user' => $user,
        ]);
    }

    public function destroy(Request $request)
    {
        Auth::guard('web')->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json(['success' => true]);
    }
}
