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
    Schema::create('detail_kebakaran', function (Blueprint $table) {
        $table->foreignId('kejadian_id')
            ->primary()
            ->constrained('kejadian')
            ->cascadeOnDelete();

        $table->string('objek_terbakar', 100)->nullable();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('detail_kebakaran');
    }
};
