<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('hotspot_fetch_logs', function (Blueprint $table) {
            $table->id();
            $table->string('status', 20)->default('running');
            $table->unsignedInteger('total_fetched')->default(0);
            $table->unsignedInteger('total_filtered')->default(0);
            $table->unsignedInteger('total_saved')->default(0);
            $table->unsignedInteger('total_duplicates')->default(0);
            $table->unsignedInteger('total_outside_area')->default(0);
            $table->json('source_errors')->nullable();
            $table->text('message')->nullable();
            $table->timestamp('started_at');
            $table->timestamp('finished_at')->nullable();
            $table->timestamps();

            $table->index(['status', 'started_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('hotspot_fetch_logs');
    }
};
