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
    Schema::create('pendaftaran_edukasi', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kegiatan_id')
            ->constrained('kegiatan_edukasi')
            ->cascadeOnDelete();

        $table->string('nama_pendaftar', 100);
        $table->string('no_hp', 20);
        $table->string('email', 100)->nullable();
        $table->string('instansi_asal', 150)->nullable();

        $table->unsignedInteger('jumlah_peserta')->default(1);

        $table->text('catatan')->nullable();

        $table->enum('status', [
            'menunggu',
            'terkonfirmasi',
            'hadir',
            'dibatalkan'
        ])->default('menunggu');

        $table->timestamp('tanggal_daftar')->useCurrent();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pendaftaran_edukasi');
    }
};
