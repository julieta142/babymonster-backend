<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('support_messages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->foreignId('admin_id')->nullable()->constrained('users')->onDelete('set null');
            $table->string('subject');
            $table->text('message');
            $table->text('admin_response')->nullable();
            $table->enum('status', ['pending', 'in_review', 'resolved', 'rejected'])->default('pending');
            $table->string('rejection_reason')->nullable();
            $table->timestamp('read_at')->nullable();
            $table->timestamp('responded_at')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('support_messages');
    }
};
