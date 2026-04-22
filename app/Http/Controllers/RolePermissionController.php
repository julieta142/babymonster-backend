<?php
// app/Http/Controllers/RolePermissionController.php

namespace App\Http\Controllers;

use App\Models\Role;
use App\Models\Permission;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class RolePermissionController extends Controller
{
    public function getRoles()
    {
        try {
            $roles = Role::whereIn('name', ['superadmin', 'admin', 'user'])->with('permissions')->get();

            return response()->json([
                'success' => true,
                'data' => $roles
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getPermissions()
    {
        try {
            $permissions = Permission::all();

            return response()->json([
                'success' => true,
                'data' => $permissions
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

    public function getRolePermissions(Role $role)
    {
        try {
            return response()->json([
                'success' => true,
                'data' => $role->load('permissions')
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
