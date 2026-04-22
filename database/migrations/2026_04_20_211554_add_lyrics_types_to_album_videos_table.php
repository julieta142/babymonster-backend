<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddLyricsTypesToAlbumVideosTable extends Migration
{
    public function up()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            $table->text('lyrics_original')->nullable()->after('lyrics');
            $table->text('lyrics_romanized')->nullable()->after('lyrics_original');
        });
    }

    public function down()
    {
        Schema::table('album_videos', function (Blueprint $table) {
            $table->dropColumn(['lyrics_original', 'lyrics_romanized']);
        });
    }
}
