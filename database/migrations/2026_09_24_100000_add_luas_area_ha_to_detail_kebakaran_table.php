<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('detail_kebakaran', function (Blueprint $table) {
            // Luas area terdampak dalam hektare
            $table->decimal('luas_area_ha', 10, 2)
                ->nullable()
                ->after('objek_terbakar');
        });
    }

    public function down(): void
    {
        Schema::table('detail_kebakaran', function (Blueprint $table) {
            $table->dropColumn('luas_area_ha');
        });
    }
};
