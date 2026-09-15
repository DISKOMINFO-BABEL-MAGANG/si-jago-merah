<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('hotspots', function (Blueprint $table) {
            $table->dropUnique('hotspots_unique_detection');
            $table->unique(
                ['latitude', 'longitude', 'acq_date', 'acq_time', 'source'],
                'hotspots_unique_detection'
            );
        });
    }

    public function down(): void
    {
        Schema::table('hotspots', function (Blueprint $table) {
            $table->dropUnique('hotspots_unique_detection');
            $table->unique(
                ['latitude', 'longitude', 'acq_date', 'acq_time', 'satellite'],
                'hotspots_unique_detection'
            );
        });
    }
};
