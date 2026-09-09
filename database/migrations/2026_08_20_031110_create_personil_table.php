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
    Schema::create('personil', function (Blueprint $table) {
        $table->id();
        $table->foreignId('user_id')
            ->nullable()
            ->unique()
            ->constrained('users')
            ->nullOnDelete();

        $table->string('nama', 100);
        $table->string('nrp', 30)->nullable()->unique();
        $table->string('jabatan', 50)->nullable();
        $table->string('no_hp', 20)->nullable();

        $table->foreignId('pos_id')
            ->nullable()
            ->constrained('pos_damkar')
            ->nullOnDelete();

        $table->enum('status', ['aktif', 'nonaktif'])
            ->default('aktif');

        $table->timestamp('dibuat_pada')->useCurrent();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('personil');
    }
};
