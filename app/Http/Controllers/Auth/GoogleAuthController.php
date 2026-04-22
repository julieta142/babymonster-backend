<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\LoginHistory;
use App\Mail\WelcomeMail;
use App\Mail\LoginNotificationMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Laravel\Socialite\Facades\Socialite;

class GoogleAuthController extends Controller
{
    public function redirectToGoogle()
    {
        try {
            Log::info('Redirecting to Google OAuth');
            return Socialite::driver('google')->redirect();
        } catch (\Exception $e) {
            Log::error('Google redirect error: ' . $e->getMessage());
            return redirect()->to(config('app.frontend_url') . '/login?error=google_redirect_failed');
        }
    }
public function handleGoogleCallback(Request $request)
{
    try {
        Log::info('Processing Google callback');

        $googleUser = Socialite::driver('google')->user();

        $user = User::where('google_id', $googleUser->getId())->first();

        if (!$user) {
            $user = User::where('email', $googleUser->getEmail())->first();

            if ($user) {
                $user->update([
                    'google_id' => $googleUser->getId(),
                    'google_avatar' => $googleUser->getAvatar()
                ]);
                $isNewUser = false;
            } else {
                $username = $this->generateUniqueUsername($googleUser->getName());

                $user = User::create([
                    'name' => $username,
                    'email' => $googleUser->getEmail(),
                    'google_id' => $googleUser->getId(),
                    'google_avatar' => $googleUser->getAvatar(),
                    'password' => Hash::make(Str::random(24)),
                    'email_verified_at' => now(),
                ]);

                $user->assignRole('user');
                $isNewUser = true;

                try {
                    Mail::to($user->email)->send(new WelcomeMail($user));
                } catch (\Exception $e) {
                    Log::error('Failed to send welcome email: ' . $e->getMessage());
                }
            }
        } else {
            $isNewUser = false;
        }

        if ($user->is_blocked) {
            Log::warning('Blocked user tried to login with Google:', ['user_id' => $user->id]);

            $rejectedMessage = \App\Models\SupportMessage::where('user_id', $user->id)
                ->where('status', 'rejected')
                ->first();

            if ($rejectedMessage && $rejectedMessage->rejection_reason) {
                $rejectionData = [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'rejection_reason' => $rejectedMessage->rejection_reason,
                    'admin_response' => $rejectedMessage->admin_response
                ];

                return redirect()->to(config('app.frontend_url') . '/login?error=account_blocked&rejection=true&rejection_reason=' . urlencode($rejectedMessage->rejection_reason) . '&blocked_user=' . urlencode(json_encode($rejectionData)));
            }

            $blockedUserData = [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email
            ];

            return redirect()->to(config('app.frontend_url') . '/login?error=account_blocked&blocked_user=' . urlencode(json_encode($blockedUserData)));
        }

        Auth::login($user);
        $this->updateLastLogin($user);
        $this->recordLogin($user, 'google');

        $loginHistory = $this->recordLogin($user, 'google');

        if (!$isNewUser) {
            try {
                Mail::to($user->email)->send(new LoginNotificationMail($user, $loginHistory));
            } catch (\Exception $e) {
                Log::error('Failed to send login notification: ' . $e->getMessage());
            }
        }

        $token = $user->createToken('google-auth-token')->plainTextToken;

        $userData = [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'avatar_url' => $user->avatar_url,
            'is_new' => $isNewUser,
            'needs_username' => $isNewUser && !preg_match('/^[a-zA-Z]/', $user->name)
        ];

        $frontendUrl = config('app.frontend_url', 'http://localhost:3000');
        $redirectUrl = $frontendUrl . '/oauth-callback?token=' . $token . '&user=' . urlencode(json_encode($userData));

        return redirect()->to($redirectUrl);
    } catch (\Exception $e) {
        Log::error('Google auth callback error: ' . $e->getMessage());
        return redirect()->to(config('app.frontend_url') . '/login?error=google_auth_failed');
    }
}
    private function generateUniqueUsername($name)
    {
        $baseUsername = strtolower(preg_replace('/[^a-zA-Z0-9]/', '', $name));

        if (empty($baseUsername)) {
            $baseUsername = 'user';
        }

        $username = $baseUsername;
        $counter = 1;

        while (User::where('name', $username)->exists()) {
            $username = $baseUsername . $counter;
            $counter++;
        }

        return $username;
    }

    private function updateLastLogin($user)
    {
        $user->update([
            'last_login_at' => now(),
            'last_login_ip' => request()->ip()
        ]);
    }

    private function recordLogin($user, $provider)
    {
        $userAgent = request()->userAgent();

        return LoginHistory::create([
            'user_id' => $user->id,
            'provider' => $provider,
            'ip_address' => request()->ip(),
            'user_agent' => $userAgent,
            'device_type' => $this->getDeviceType($userAgent),
            'browser' => $this->getBrowser($userAgent),
            'os' => $this->getOS($userAgent),
            'login_at' => now()
        ]);
    }

    private function getDeviceType($userAgent)
    {
        if (str_contains($userAgent, 'Mobile')) return 'mobile';
        if (str_contains($userAgent, 'Tablet')) return 'tablet';
        return 'desktop';
    }

    private function getBrowser($userAgent)
    {
        if (str_contains($userAgent, 'Chrome')) return 'Chrome';
        if (str_contains($userAgent, 'Firefox')) return 'Firefox';
        if (str_contains($userAgent, 'Safari')) return 'Safari';
        if (str_contains($userAgent, 'Edge')) return 'Edge';
        return 'Unknown';
    }

    private function getOS($userAgent)
    {
        if (str_contains($userAgent, 'Windows')) return 'Windows';
        if (str_contains($userAgent, 'Mac')) return 'macOS';
        if (str_contains($userAgent, 'Linux')) return 'Linux';
        if (str_contains($userAgent, 'Android')) return 'Android';
        if (str_contains($userAgent, 'iOS')) return 'iOS';
        return 'Unknown';
    }

    public function disconnectGoogle(Request $request)
    {
        try {
            $user = $request->user();

            if (!$user->password) {
                return response()->json([
                    'success' => false,
                    'message' => 'You need to set a password before disconnecting Google.'
                ], 400);
            }

            $user->update([
                'google_id' => null,
                'google_avatar' => null
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Google account disconnected successfully.'
            ]);
        } catch (\Exception $e) {
            Log::error('Disconnect Google error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to disconnect Google account.'
            ], 500);
        }
    }

    public function setUsername(Request $request)
    {
        try {
            $request->validate([
                'username' => 'required|string|min:3|max:255|unique:users,name'
            ]);

            $user = $request->user();
            $user->name = $request->username;
            $user->save();

            return response()->json([
                'success' => true,
                'user' => $user,
                'message' => 'Username set successfully!'
            ]);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Set username error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to set username.'
            ], 500);
        }
    }

    public function getLoginHistory(Request $request)
    {
        try {
            $histories = $request->user()
                ->loginHistories()
                ->orderBy('login_at', 'desc')
                ->limit(50)
                ->get();
            return response()->json([
                'success' => true,
                'data' => $histories
            ]);
        } catch (\Exception $e) {
            Log::error('Get login history error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to fetch login history.'
            ], 500);
        }
    }
}
