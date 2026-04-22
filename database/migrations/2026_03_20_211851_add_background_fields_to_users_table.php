<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('background')->nullable()->after('avatar');
            $table->string('background_type')->default('video')->after('background');
            $table->string('background_url')->nullable()->after('background_type');
        });
    }

    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['background', 'background_type', 'background_url']);
        });
    }
};
