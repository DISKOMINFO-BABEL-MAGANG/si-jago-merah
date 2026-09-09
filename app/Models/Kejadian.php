<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Kejadian extends Model
{
    protected $table = 'kejadian';

    public $timestamps = false;

    protected $fillable = [
        'laporan_warga_id',
        'jenis_kejadian',
        'tanggal_kejadian',
        'waktu_kejadian',
        'alamat_lokasi',
        'latitude',
        'longitude',
        'pelapor_asal',
        'no_kontak_pelapor',
        'waktu_laporan_diterima',
        'waktu_tiba_lokasi',
        'kronologi',
        'pemilik',
        'dampak_kerugian',
        'korban_luka',
        'korban_meninggal',
        'kendala_lapangan',
        'pos_id',
        'waktu_selesai',
        'dibuat_pada',
    ];

    protected $casts = [
        'tanggal_kejadian' => 'date',
        'waktu_kejadian' => 'datetime',
        'waktu_laporan_diterima' => 'datetime',
        'waktu_tiba_lokasi' => 'datetime',
        'waktu_selesai' => 'datetime',
        'dibuat_pada' => 'datetime',
        'latitude' => 'decimal:7',
        'longitude' => 'decimal:7',
    ];

    public function laporanWarga(): BelongsTo
    {
        return $this->belongsTo(
            LaporanWarga::class,
            'laporan_warga_id'
        );
    }

    public function pos(): BelongsTo
    {
        return $this->belongsTo(
            PosDamkar::class,
            'pos_id'
        );
    }

    public function detailKebakaran(): HasOne
    {
        return $this->hasOne(
            DetailKebakaran::class,
            'kejadian_id'
        );
    }

    public function detailEvakuasi(): HasOne
    {
        return $this->hasOne(
            DetailEvakuasi::class,
            'kejadian_id'
        );
    }

    public function personil(): BelongsToMany
    {
        return $this->belongsToMany(
            Personil::class,
            'kejadian_regu',
            'kejadian_id',
            'personil_id'
        );
    }

    public function kendaraan(): BelongsToMany
    {
        return $this->belongsToMany(
            Kendaraan::class,
            'kejadian_kendaraan',
            'kejadian_id',
            'kendaraan_id'
        );
    }

    public function instansiBantuan(): BelongsToMany
    {
        return $this->belongsToMany(
            InstansiBantuan::class,
            'kejadian_bantuan',
            'kejadian_id',
            'instansi_id'
        )->withPivot('keterangan');
    }

    public function foto(): HasMany
    {
        return $this->hasMany(
            KejadianFoto::class,
            'kejadian_id'
        );
    }
}