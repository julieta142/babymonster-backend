<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Role;
use Illuminate\Support\Facades\Hash;

class SuperadminSeeder extends Seeder
{
    public function run()
    {
        // Check if roles exist
        $superadminRole = Role::where('name', 'superadmin')->first();

        if (!$superadminRole) {
            $this->command->error('✗ Superadmin role not found! Please run RolePermissionSeeder first.');
            return;
        }

        // Create superadmin user
        $superadmin = User::updateOrCreate(
            ['email' => 'superadmin@example.com'],
            [
                'name' => 'Super Admin',
                'password' => Hash::make('password123'),
                'email_verified_at' => now(),
                'is_private' => false,
            ]
        );

        // Assign superadmin role
        if (!$superadmin->hasRole('superadmin')) {
            $superadmin->assignRole('superadmin');
        }

        $this->command->info('✓ Superadmin user created/updated successfully!');
        $this->command->info('   Email: superadmin@example.com');
        $this->command->info('   Password: password123');
        $this->command->info('   Role: superadmin');
    }
}
