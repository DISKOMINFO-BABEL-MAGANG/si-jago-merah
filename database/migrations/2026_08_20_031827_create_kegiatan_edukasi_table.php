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
    Schema::create('kegiatan_edukasi', function (Blueprint $table) {
        $table->id();

        $table->date('tanggal');
        $table->time('waktu')->nullable();

        $table->string('alamat', 255)->nullable();
        $table->string('tempat', 100)->nullable();
        $table->string('jenis_tempat', 50)->nullable();

        $table->string('tema', 150)->nullable();
        $table->text('hasil_kegiatan')->nullable();

        $table->unsignedInteger('kapasitas')->default(0);

        $table->foreignId('pos_id')
            ->nullable()
            ->constrained('pos_damkar')
            ->nullOnDelete();

        $table->enum('status', [
            'terjadwal',
            'berlangsung',
            'selesai',
            'dibatalkan'
        ])->default('terjadwal');

        $table->timestamp('dibuat_pada')->useCurrent();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kegiatan_edukasi');
    }
};
