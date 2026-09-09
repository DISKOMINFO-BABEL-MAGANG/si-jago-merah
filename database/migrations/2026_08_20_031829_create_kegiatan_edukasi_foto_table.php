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
    Schema::create('kegiatan_edukasi_foto', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kegiatan_id')
            ->constrained('kegiatan_edukasi')
            ->cascadeOnDelete();

        $table->string('url_foto', 255);
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kegiatan_edukasi_foto');
    }
};
