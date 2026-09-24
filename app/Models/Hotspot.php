<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Hotspot extends Model
{
    protected $fillable = [
        'latitude',
        'longitude',
        'source',
        'region',
        'bright_ti4',
        'scan',
        'track',
        'acq_date',
        'acq_time',
        'satellite',
        'instrument',
        'confidence',
        'version',
        'bright_ti5',
        'frp',
        'daynight',
    ];

    protected $casts = [
        'latitude' => 'float',
        'longitude' => 'float',
        'bright_ti4' => 'float',
        'scan' => 'float',
        'track' => 'float',
        'bright_ti5' => 'float',
        'frp' => 'float',
        'acq_date' => 'date:Y-m-d',
    ];
}