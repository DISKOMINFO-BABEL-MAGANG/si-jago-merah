<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HotspotFetchLog extends Model
{
    protected $guarded = [];

    protected function casts(): array
    {
        return [
            'source_errors' => 'array',
            'started_at' => 'datetime',
            'finished_at' => 'datetime',
        ];
    }
}
