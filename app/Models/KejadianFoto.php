<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KejadianFoto extends Model
{
    protected $table = 'kejadian_foto';

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'url_foto',
        'keterangan',
        'diunggah_pada',
    ];

    protected $casts = [
        'diunggah_pada' => 'datetime',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }
}