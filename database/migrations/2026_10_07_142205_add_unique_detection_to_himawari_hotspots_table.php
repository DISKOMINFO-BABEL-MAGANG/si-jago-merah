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
        Schema::table('himawari_hotspots', function (Blueprint $table) {
            $table->unique(
                [
                    'latitude',
                    'longitude',
                    'acq_date',
                    'acq_time',
                    'source',
                ],
                'himawari_hotspots_unique_detection'
            );
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('himawari_hotspots', function (Blueprint $table) {
            $table->dropUnique('himawari_hotspots_unique_detection');
        });
    }
};