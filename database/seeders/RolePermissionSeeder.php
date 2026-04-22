<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Role;
use App\Models\Permission;
use Illuminate\Support\Facades\DB;

class RolePermissionSeeder extends Seeder
{
    public function run()
    {
        // Create permissions
        $permissions = [
            ['name' => 'view_users', 'display_name' => 'View Users', 'group' => 'users'],
            ['name' => 'block_users', 'display_name' => 'Block/Unblock Users', 'group' => 'users'],
            ['name' => 'manage_roles', 'display_name' => 'Manage Roles', 'group' => 'users'],
            ['name' => 'manage_permissions', 'display_name' => 'Manage Permissions', 'group' => 'users'],
            ['name' => 'assign_roles', 'display_name' => 'Assign Roles to Users', 'group' => 'users'],
            ['name' => 'edit_videos', 'display_name' => 'Edit Videos', 'group' => 'videos'],
            ['name' => 'delete_videos', 'display_name' => 'Delete Videos', 'group' => 'videos'],
            ['name' => 'upload_videos', 'display_name' => 'Upload Videos', 'group' => 'videos'],
            ['name' => 'edit_profile', 'display_name' => 'Edit Profile', 'group' => 'profile'],
        ];

        foreach ($permissions as $permission) {
            Permission::updateOrCreate(
                ['name' => $permission['name']],
                $permission
            );
        }

        $this->command->info('✓ Created ' . count($permissions) . ' permissions');

        // Create roles
        $roles = [
            [
                'name' => 'superadmin',
                'display_name' => 'Super Administrator',
                'description' => 'Has full access to everything'
            ],
            [
                'name' => 'admin',
                'display_name' => 'Administrator',
                'description' => 'Has all access except user management'
            ],
            [
                'name' => 'user',
                'display_name' => 'Regular User',
                'description' => 'Basic user access'
            ]
        ];

        foreach ($roles as $roleData) {
            Role::updateOrCreate(
                ['name' => $roleData['name']],
                $roleData
            );
        }

        $this->command->info('✓ Created ' . count($roles) . ' roles');

        // Get roles
        $superadmin = Role::where('name', 'superadmin')->first();
        $admin = Role::where('name', 'admin')->first();
        $user = Role::where('name', 'user')->first();

        // Assign all permissions to superadmin
        $allPermissions = Permission::all();
        $superadmin->permissions()->sync($allPermissions->pluck('id'));
        $this->command->info('✓ Assigned ' . $allPermissions->count() . ' permissions to Superadmin');

        // Assign permissions to admin (exclude user management)
        $adminPermissions = Permission::whereNotIn('name', [
            'view_users', 'block_users', 'manage_roles', 'manage_permissions', 'assign_roles'
        ])->get();
        $admin->permissions()->sync($adminPermissions->pluck('id'));
        $this->command->info('✓ Assigned ' . $adminPermissions->count() . ' permissions to Admin');

        // Assign permissions to regular user
        $userPermissions = Permission::whereIn('name', ['edit_profile', 'upload_videos'])->get();
        $user->permissions()->sync($userPermissions->pluck('id'));
        $this->command->info('✓ Assigned ' . $userPermissions->count() . ' permissions to User');

        $this->command->info('✓ Roles and permissions seeded successfully!');
    }
}
