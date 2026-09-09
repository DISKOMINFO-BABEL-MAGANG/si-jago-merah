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
    Schema::create('kejadian', function (Blueprint $table) {
        $table->id();

        $table->foreignId('laporan_warga_id')
            ->nullable()
            ->constrained('laporan_warga')
            ->nullOnDelete();

        $table->enum('jenis_kejadian', [
            'kebakaran',
            'evakuasi_penyelamatan'
        ]);

        $table->date('tanggal_kejadian');
        $table->time('waktu_kejadian')->nullable();

        $table->string('alamat_lokasi', 255)->nullable();

        $table->decimal('latitude', 10, 7)->nullable();
        $table->decimal('longitude', 10, 7)->nullable();

        $table->string('pelapor_asal', 100)->nullable();
        $table->string('no_kontak_pelapor', 20)->nullable();

        $table->dateTime('waktu_laporan_diterima')->nullable();
        $table->dateTime('waktu_tiba_lokasi')->nullable();

        $table->text('kronologi')->nullable();
        $table->string('pemilik', 100)->nullable();
        $table->text('dampak_kerugian')->nullable();

        $table->unsignedInteger('korban_luka')->default(0);
        $table->unsignedInteger('korban_meninggal')->default(0);

        $table->text('kendala_lapangan')->nullable();

        $table->foreignId('pos_id')
            ->nullable()
            ->constrained('pos_damkar')
            ->nullOnDelete();

        $table->dateTime('waktu_selesai')->nullable();

        $table->timestamp('dibuat_pada')->useCurrent();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kejadian');
    }
};
