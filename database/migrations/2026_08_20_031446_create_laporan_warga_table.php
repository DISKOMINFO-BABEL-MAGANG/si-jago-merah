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
    Schema::create('laporan_warga', function (Blueprint $table) {
        $table->id();

        $table->string('nama_pelapor', 100)->nullable();
        $table->string('no_kontak_pelapor', 20)->nullable();

        $table->string('alamat_lokasi', 255)->nullable();

        $table->decimal('latitude', 10, 7)->nullable();
        $table->decimal('longitude', 10, 7)->nullable();

        $table->enum('jenis_laporan', [
            'kebakaran',
            'evakuasi_penyelamatan'
        ]);

        $table->text('deskripsi_singkat')->nullable();
        $table->string('foto_url', 255)->nullable();

        $table->timestamp('waktu_lapor')->useCurrent();

        $table->enum('status', [
            'baru',
            'diverifikasi',
            'ditindaklanjuti',
            'ditolak'
        ])->default('baru');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('laporan_warga');
    }
};
