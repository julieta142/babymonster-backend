<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            $table->string('audio_file')->nullable()->after('duration');
            $table->string('audio_file_name')->nullable()->after('audio_file');
        });
    }

    public function down()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            $table->dropColumn(['audio_file', 'audio_file_name']);
        });
    }
};
