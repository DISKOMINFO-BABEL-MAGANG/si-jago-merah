<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KejadianKendaraan extends Model
{
    protected $table = 'kejadian_kendaraan';

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'kendaraan_id',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }

    public function kendaraan(): BelongsTo
    {
        return $this->belongsTo(
            Kendaraan::class,
            'kendaraan_id'
        );
    }
}