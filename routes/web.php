<?php

use Illuminate\Support\Facades\Route;
use App\Models\Hotspot;
use App\Http\Controllers\KejadianController;

Route::get('/', function () {return view('home');});

Route::get('/gis/kejadian', [KejadianController::class, 'index']);
Route::post('/gis/kejadian', [KejadianController::class, 'store'])
    ->middleware('throttle:20,1');
    
// =====================================================
// GIS - DATA HOTSPOT
// =====================================================

Route::get('/gis/hotspots', function () {
    $today = now()->toDateString();
    $yesterday = now()->subDay()->toDateString();

    return response()->json(
        Hotspot::whereBetween('acq_date', [
            $yesterday,
            $today,
        ])
        ->latest('acq_date')
        ->get()
    );
});

// =====================================================
// GIS - MAP
// =====================================================

Route::get('/gis', function () {
    return view('gis.map');
});

Route::get('/gis/map', function () {
    return view('gis.map');
});

// =====================================================
// GIS - BOUNDARY BANGKA BELITUNG
// =====================================================

Route::get('/gis/boundary', function () {

    $path = storage_path(
        'app/private/geo/bangka-belitung.geojson'
    );

    if (!file_exists($path)) {
        return response()->json([
            'message' => 'File boundary tidak ditemukan.'
        ], 404);
    }

    return response()->file(
        $path,
        [
            'Content-Type' => 'application/geo+json'
        ]
    );
});
