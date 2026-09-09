<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class KegiatanEdukasiPersonil extends Model
{
    protected $table = 'kegiatan_edukasi_personil';

    public $timestamps = false;

    protected $fillable = [
        'kegiatan_id',
        'personil_id',
        'peran',
    ];

    public function kegiatan(): BelongsTo
    {
        return $this->belongsTo(
            KegiatanEdukasi::class,
            'kegiatan_id'
        );
    }

    public function personil(): BelongsTo
    {
        return $this->belongsTo(
            Personil::class,
            'personil_id'
        );
    }
}