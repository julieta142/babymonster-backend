<?php
// app/Http/Controllers/UserManagementController.php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Role;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Auth;

class UserManagementController extends Controller
{
    public function index(Request $request)
    {
        try {
            $user = $request->user();

            if (!$user || !$user->hasRole('superadmin')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Unauthorized - Superadmin access required'
                ], 403);
            }

            $users = User::with('roles')->paginate(20);

            return response()->json([
                'success' => true,
                'data' => $users->items(),
                'meta' => [
                    'current_page' => $users->currentPage(),
                    'last_page' => $users->lastPage(),
                    'total' => $users->total()
                ]
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function show(User $user)
    {
        return response()->json([
            'success' => true,
            'data' => $user->load('roles')
        ]);
    }

    public function blockUser(User $user)
    {
        $currentUser = Auth::user();

        if (!$currentUser->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only superadmin can block users'
            ], 403);
        }

        if ($user->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Cannot block superadmin user'
            ], 403);
        }

        if ($user->is_blocked) {
            return response()->json([
                'success' => false,
                'message' => 'User is already blocked'
            ], 400);
        }

        $user->update(['is_blocked' => true]);

        return response()->json([
            'success' => true,
            'message' => 'User blocked successfully',
            'data' => $user->fresh('roles')
        ]);
    }

    public function unblockUser(User $user)
    {
        $currentUser = Auth::user();

        if (!$currentUser->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only superadmin can unblock users'
            ], 403);
        }

        if (!$user->is_blocked) {
            return response()->json([
                'success' => false,
                'message' => 'User is not blocked'
            ], 400);
        }

        $user->update(['is_blocked' => false]);

        return response()->json([
            'success' => true,
            'message' => 'User unblocked successfully',
            'data' => $user->fresh('roles')
        ]);
    }

    public function assignRole(Request $request, User $user)
    {
        $currentUser = Auth::user();

        if (!$currentUser->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Only superadmin can assign roles'
            ], 403);
        }

        $validator = Validator::make($request->all(), [
            'role' => 'required|in:admin,user'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'errors' => $validator->errors()
            ], 422);
        }

        $roleName = $request->role;

        if ($user->hasRole('superadmin')) {
            return response()->json([
                'success' => false,
                'message' => 'Cannot modify superadmin user role'
            ], 403);
        }

        $user->roles()->detach();
        $user->assignRole($roleName);

        return response()->json([
            'success' => true,
            'message' => 'Role assigned successfully',
            'data' => $user->fresh('roles')
        ]);
    }
}
