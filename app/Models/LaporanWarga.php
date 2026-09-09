<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasOne;

class LaporanWarga extends Model
{
    protected $table = 'laporan_warga';

    public $timestamps = false;

    protected $fillable = [
        'nama_pelapor',
        'no_kontak_pelapor',
        'alamat_lokasi',
        'latitude',
        'longitude',
        'jenis_laporan',
        'deskripsi_singkat',
        'foto_url',
        'waktu_lapor',
        'status',
    ];

    protected $casts = [
        'waktu_lapor' => 'datetime',
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
    ];

    public function kejadian(): HasOne
    {
        return $this->hasOne(Kejadian::class, 'laporan_warga_id');
    }
}