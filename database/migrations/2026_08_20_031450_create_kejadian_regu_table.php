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
    Schema::create('kejadian_regu', function (Blueprint $table) {
        $table->id();

        $table->foreignId('kejadian_id')
            ->constrained('kejadian')
            ->cascadeOnDelete();

        $table->foreignId('personil_id')
            ->constrained('personil')
            ->cascadeOnDelete();

        $table->unique([
            'kejadian_id',
            'personil_id'
        ], 'uq_kejadian_personil');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('kejadian_regu');
    }
};
