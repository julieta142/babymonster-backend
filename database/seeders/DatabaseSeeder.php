<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DatabaseSeeder extends Seeder
{
    public function run()
    {

        $this->call([
            RolePermissionSeeder::class,
            SuperadminSeeder::class,
        ]);

        $this->command->info('✓ All seeders completed successfully!');
        $this->command->info('Superadmin Email: superadmin@example.com');
        $this->command->info('Superadmin Password: password123');
    }
}
