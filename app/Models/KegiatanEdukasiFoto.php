<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KegiatanEdukasiFoto extends Model
{
    protected $table = 'kegiatan_edukasi_foto';

    public $timestamps = false;

    protected $fillable = [
        'kegiatan_id',
        'url_foto',
    ];

    public function kegiatan(): BelongsTo
    {
        return $this->belongsTo(
            KegiatanEdukasi::class,
            'kegiatan_id'
        );
    }
}