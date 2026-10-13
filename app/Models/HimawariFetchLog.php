<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HimawariFetchLog extends Model
{
    protected $guarded = [];

    protected function casts(): array
    {
        return [
            'observation_time' => 'datetime',
            'source_errors' => 'array',
            'started_at' => 'datetime',
            'finished_at' => 'datetime',
        ];
    }
}
