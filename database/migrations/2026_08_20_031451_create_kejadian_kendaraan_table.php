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
    Schema::create('kejadian_kendaraan', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kejadian_id')
            ->constrained('kejadian')
            ->cascadeOnDelete();

        $table->foreignId('kendaraan_id')
            ->constrained('kendaraan')
            ->cascadeOnDelete();

        $table->unique([
            'kejadian_id',
            'kendaraan_id'
        ], 'uq_kejadian_kendaraan');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kejadian_kendaraan');
    }
};
