<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('albums', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('album_art')->nullable();
            $table->text('description')->nullable();
            $table->date('release_date')->nullable();
            $table->string('artist')->default('BABYMONSTER');
            $table->integer('rating')->nullable();
            $table->integer('order')->default(0);
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('albums');
    }
};
