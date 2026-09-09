<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KejadianBantuan extends Model
{
    protected $table = 'kejadian_bantuan';

    public $timestamps = false;

    protected $fillable = [
        'kejadian_id',
        'instansi_id',
        'keterangan',
    ];

    public function kejadian(): BelongsTo
    {
        return $this->belongsTo(
            Kejadian::class,
            'kejadian_id'
        );
    }

    public function instansi(): BelongsTo
    {
        return $this->belongsTo(
            InstansiBantuan::class,
            'instansi_id'
        );
    }
}