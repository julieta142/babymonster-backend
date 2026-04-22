<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('tour_countries', function (Blueprint $table) {
            // Rename 'concert_date' to 'start_date' and add 'end_date'
            $table->renameColumn('concert_date', 'start_date');
            $table->date('end_date')->nullable()->after('start_date');
        });
    }

    public function down(): void
    {
        Schema::table('tour_countries', function (Blueprint $table) {
            $table->renameColumn('start_date', 'concert_date');
            $table->dropColumn('end_date');
        });
    }
};
