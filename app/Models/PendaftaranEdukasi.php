<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class PendaftaranEdukasi extends Model
{
    protected $table = 'pendaftaran_edukasi';

    public $timestamps = false;

    protected $fillable = [
        'kegiatan_id',
        'nama_pendaftar',
        'no_hp',
        'email',
        'instansi_asal',
        'jumlah_peserta',
        'catatan',
        'status',
        'tanggal_daftar',
    ];

    protected $casts = [
        'tanggal_daftar' => 'datetime',
    ];

    public function kegiatan(): BelongsTo
    {
        return $this->belongsTo(
            KegiatanEdukasi::class,
            'kegiatan_id'
        );
    }
}