<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class KegiatanEdukasi extends Model
{
    protected $table = 'kegiatan_edukasi';

    public $timestamps = false;

    protected $fillable = [
        'tanggal',
        'waktu',
        'alamat',
        'tempat',
        'jenis_tempat',
        'tema',
        'hasil_kegiatan',
        'kapasitas',
        'pos_id',
        'status',
        'dibuat_pada',
    ];

    protected $casts = [
        'tanggal' => 'date',
        'waktu' => 'datetime',
        'dibuat_pada' => 'datetime',
    ];

    public function pos(): BelongsTo
    {
        return $this->belongsTo(PosDamkar::class, 'pos_id');
    }

    public function personil(): BelongsToMany
    {
        return $this->belongsToMany(
            Personil::class,
            'kegiatan_edukasi_personil',
            'kegiatan_id',
            'personil_id'
        )->withPivot('peran');
    }

    public function foto(): HasMany
    {
        return $this->hasMany(
            KegiatanEdukasiFoto::class,
            'kegiatan_id'
        );
    }

    public function pendaftaran(): HasMany
    {
        return $this->hasMany(
            PendaftaranEdukasi::class,
            'kegiatan_id'
        );
    }
}