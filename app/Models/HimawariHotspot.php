<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HimawariHotspot extends Model
{
    protected $fillable = [
        'latitude',
        'longitude',
        'source',
        'satellite',
        'instrument',
        'acq_date',
        'acq_time',
        'bt07',
        'bt14',
        'bt_difference',
        'pixel_count',
        'region',
    ];

    protected function casts(): array
    {
        return [
            'latitude' => 'float',
            'longitude' => 'float',
            'bt07' => 'float',
            'bt14' => 'float',
            'bt_difference' => 'float',
            'acq_date' => 'string',
            'pixel_count' => 'integer',
        ];
    }
}