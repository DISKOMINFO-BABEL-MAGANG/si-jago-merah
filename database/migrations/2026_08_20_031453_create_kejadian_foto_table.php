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
    Schema::create('kejadian_foto', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kejadian_id')
            ->constrained('kejadian')
            ->cascadeOnDelete();

        $table->string('url_foto', 255);
        $table->string('keterangan', 255)->nullable();

        $table->timestamp('diunggah_pada')->useCurrent();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kejadian_foto');
    }
};
