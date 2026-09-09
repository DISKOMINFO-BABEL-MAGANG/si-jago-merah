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
    Schema::create('kejadian_bantuan', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kejadian_id')
            ->constrained('kejadian')
            ->cascadeOnDelete();

        $table->foreignId('instansi_id')
            ->constrained('instansi_bantuan')
            ->cascadeOnDelete();

        $table->string('keterangan', 255)->nullable();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kejadian_bantuan');
    }
};
