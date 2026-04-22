<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Hash;

class ProfileController extends Controller
{
    public function update(Request $request)
    {
        $user = $request->user();

        $rules = [
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'email', Rule::unique('users')->ignore($user->id)],
            'bio' => ['nullable', 'string', 'max:1000'],
            'gender' => ['nullable', 'string', Rule::in(['male', 'female', 'prefer_not_to_say'])],
            'is_private' => ['required', 'boolean'],
        ];

        if ($request->hasFile('background')) {
            $rules['background'] = ['nullable', 'image', 'max:2048'];
        }

        $data = $request->validate($rules);

        if ($request->hasFile('background')) {
            if ($user->background_url && !str_starts_with($user->background_url, '/uploads/')) {
                $oldPath = str_replace('/storage/', '', $user->background_url);
                if (Storage::disk('public')->exists($oldPath)) {
                    Storage::disk('public')->delete($oldPath);
                }
            }

            $path = $request->file('background')->store('profile-backgrounds', 'public');
            $user->background_url = '/storage/' . $path;
        }
        elseif ($request->has('background_url')) {
            $user->background_url = $request->background_url ?: null;
        }

        $user->name = $data['name'];
        $user->email = $data['email'];
        $user->bio = $data['bio'] ?? null;
        $user->gender = $data['gender'] ?? null;
        $user->is_private = $data['is_private'];

        $user->save();

        return response()->json([
            'success' => true,
            'user' => [
                'id' => $user->id,
                'name' => $user->name,
                'email' => $user->email,
                'bio' => $user->bio,
                'gender' => $user->gender,
                'is_private' => (bool)$user->is_private,
                'avatar_url' => $user->avatar_url,
                'background_url' => $user->background_url,
            ],
            'message' => 'Profile updated successfully'
        ]);
    }

    public function updateAvatar(Request $request)
    {
        try {
            $request->validate([
                'avatar' => ['required', 'image', 'max:2048']
            ]);

            $user = $request->user();

            // Delete old avatar
            if ($user->avatar && Storage::disk('public')->exists($user->avatar)) {
                Storage::disk('public')->delete($user->avatar);
            }

            $file = $request->file('avatar');
            $filename = time() . '_' . preg_replace('/[^a-zA-Z0-9._-]/', '', $file->getClientOriginalName());
            $path = $file->storeAs('avatars', $filename, 'public');

            $user->avatar = $path;
            $user->save();

            $avatarUrl = asset('storage/' . $path);

            return response()->json([
                'success' => true,
                'avatar_url' => $avatarUrl,
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'bio' => $user->bio,
                    'gender' => $user->gender,
                    'is_private' => (bool)$user->is_private,
                    'avatar_url' => $avatarUrl,
                    'background_url' => $user->background_url,
                ],
                'message' => 'Avatar updated successfully'
            ]);
        } catch (\Exception $e) {
            Log::error('Avatar update error: ' . $e->getMessage());
            Log::error('Line: ' . $e->getLine() . ' File: ' . $e->getFile());

            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

     public function changePassword(Request $request)
    {
        try {
            $request->validate([
                'current_password' => ['required', 'current_password'],
                'new_password' => ['required', 'confirmed', 'min:8'],
            ]);

            $user = $request->user();
            $user->password = Hash::make($request->new_password);
            $user->save();

            return response()->json([
                'success' => true,
                'message' => 'Password changed successfully'
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => 'Validation failed',
                'errors' => $e->errors()
            ], 422);
        } catch (\Exception $e) {
            Log::error('Change password error: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Failed to change password: ' . $e->getMessage()
            ], 500);
        }
    }
}
