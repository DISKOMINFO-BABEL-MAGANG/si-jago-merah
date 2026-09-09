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
    Schema::create('kendaraan', function (Blueprint $table) {
        $table->id();
        $table->string('no_lambung', 30)->nullable();
        $table->string('plat_nomor', 20)->nullable();
        $table->string('jenis', 50)->nullable();

        $table->enum('status', ['siap', 'perbaikan', 'rusak'])
            ->default('siap');

        $table->foreignId('pos_id')
            ->nullable()
            ->constrained('pos_damkar')
            ->nullOnDelete();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kendaraan');
    }
};
