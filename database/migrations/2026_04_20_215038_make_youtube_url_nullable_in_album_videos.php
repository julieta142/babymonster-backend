<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class MakeYoutubeUrlNullableInAlbumVideos extends Migration
{
    public function up()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            // Make youtube_url nullable
            $table->string('youtube_url')->nullable()->change();
            // Also make youtube_id nullable
            $table->string('youtube_id')->nullable()->change();
        });
    }

    public function down()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            $table->string('youtube_url')->nullable(false)->change();
            $table->string('youtube_id')->nullable(false)->change();
        });
    }
}
