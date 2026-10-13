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
    Schema::create('himawari_hotspots', function (Blueprint $table) {
        $table->id();

        $table->decimal('latitude', 10, 7);
        $table->decimal('longitude', 10, 7);

        $table->string('source')->default('HIMAWARI9');
        $table->string('satellite')->default('H09');
        $table->string('instrument')->default('AHI');

        $table->date('acq_date');
        $table->string('acq_time', 4);

        $table->decimal('bt07', 8, 3);
        $table->decimal('bt14', 8, 3);
        $table->decimal('bt_difference', 8, 3);

        $table->unsignedInteger('pixel_count')->default(1);

        $table->string('region')->nullable();

        $table->timestamps();

        $table->index(['acq_date', 'acq_time']);
        $table->index(['latitude', 'longitude']);
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('himawari_hotspots');
    }
};
