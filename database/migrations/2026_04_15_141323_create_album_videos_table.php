<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('album_videos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('album_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->string('youtube_url');
            $table->string('youtube_id');
            $table->integer('track_number')->default(0);
            $table->integer('duration')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('album_videos');
    }
};
