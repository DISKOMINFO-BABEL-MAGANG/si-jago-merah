<?php

namespace App\Http\Controllers;

use App\Models\DetailKebakaran;
use App\Models\Kejadian;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class KejadianController extends Controller
{
    /**
     * Daftar jenis kebakaran yang diizinkan (kolom detail_kebakaran.objek_terbakar).
     */
    public const JENIS_KEBAKARAN = ['lahan', 'hutan', 'rumah'];

    /**
     * GET /gis/kejadian
     * Kejadian kebakaran yang punya koordinat, untuk ditampilkan di peta.
     */
    public function index(): JsonResponse
    {
        $kejadian = Kejadian::with('detailKebakaran')
            ->where('jenis_kejadian', 'kebakaran')
            ->whereNotNull('latitude')
            ->whereNotNull('longitude')
            ->orderByDesc('tanggal_kejadian')
            ->orderByDesc('waktu_kejadian')
            ->limit(500)
            ->get()
            ->map(fn (Kejadian $item) => $this->transform($item));

        return response()->json($kejadian);
    }

    /**
     * POST /gis/kejadian
     * Simpan titik kebakaran yang ditandai di peta.
     */
    public function store(Request $request): JsonResponse
    {
        $data = $request->validate([
            'latitude' => ['required', 'numeric', 'between:-90,90'],
            'longitude' => ['required', 'numeric', 'between:-180,180'],
            'objek_terbakar' => ['required', Rule::in(self::JENIS_KEBAKARAN)],
            'luas_area_ha' => ['nullable', 'numeric', 'min:0', 'max:1000000'],
            'korban_meninggal' => ['nullable', 'integer', 'min:0', 'max:100000'],
            'keterangan' => ['nullable', 'string', 'max:2000'],
        ]);

        $kejadian = DB::transaction(function () use ($data) {
            $now = now('Asia/Jakarta');

            $kejadian = Kejadian::create([
                'jenis_kejadian' => 'kebakaran',
                'tanggal_kejadian' => $now->toDateString(),
                'waktu_kejadian' => $now->format('H:i:s'),
                'latitude' => round((float) $data['latitude'], 7),
                'longitude' => round((float) $data['longitude'], 7),
                'korban_meninggal' => $data['korban_meninggal'] ?? 0,
                'kronologi' => $data['keterangan'] ?? null,
            ]);

            DetailKebakaran::create([
                'kejadian_id' => $kejadian->id,
                'objek_terbakar' => $data['objek_terbakar'],
                'luas_area_ha' => $data['luas_area_ha'] ?? null,
            ]);

            return $kejadian;
        });

        $kejadian->load('detailKebakaran');

        return response()->json($this->transform($kejadian), 201);
    }

    /**
     * Bentuk data yang dikirim ke peta.
     */
    protected function transform(Kejadian $kejadian): array
    {
        $detail = $kejadian->detailKebakaran;

        return [
            'id' => $kejadian->id,
            'latitude' => $kejadian->latitude,
            'longitude' => $kejadian->longitude,
            'tanggal' => $kejadian->tanggal_kejadian?->toDateString(),
            'waktu' => $kejadian->waktu_kejadian,
            'objek_terbakar' => $detail?->objek_terbakar,
            'luas_area_ha' => $detail?->luas_area_ha,
            'korban_meninggal' => $kejadian->korban_meninggal,
            'keterangan' => $kejadian->kronologi,
        ];
    }
}