<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
{
    Schema::create('hotspots', function (Blueprint $table) {
        $table->id();

        $table->decimal('latitude', 10, 6);
        $table->decimal('longitude', 10, 6);

        $table->decimal('bright_ti4', 8, 2)->nullable();
        $table->decimal('scan', 8, 4)->nullable();
        $table->decimal('track', 8, 4)->nullable();

        $table->date('acq_date')->nullable();
        $table->string('acq_time')->nullable();

        $table->string('satellite', 20)->nullable();
        $table->string('instrument', 20)->nullable();
        $table->string('confidence', 20)->nullable();
        $table->string('version', 20)->nullable();

        $table->decimal('bright_ti5', 8, 2)->nullable();
        $table->decimal('frp', 10, 2)->nullable();

        $table->string('daynight', 5)->nullable();

        $table->timestamps();

        $table->index(['latitude', 'longitude']);
        $table->index('acq_date');

        // Mencegah data hotspot yang sama masuk berkali-kali
        $table->unique(
            ['latitude', 'longitude', 'acq_date', 'acq_time', 'satellite'],
            'hotspots_unique_detection'
        );
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('hotspots');
    }
};
