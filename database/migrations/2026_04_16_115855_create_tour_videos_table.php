<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('tour_videos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('tour_id')->constrained()->onDelete('cascade');
            $table->foreignId('tour_country_id')->nullable()->constrained()->onDelete('set null');
            $table->string('title');
            $table->string('youtube_url');
            $table->string('youtube_id');
            $table->enum('video_type', ['performance', 'behind', 'vlog', 'interview'])->default('performance');
            $table->integer('sort_order')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('tour_videos');
    }
};
