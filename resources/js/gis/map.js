const map = L.map('map').setView([-2.5, 106.5], 8);

// ===============================
// FORMAT WAKTU NASA FIRMS
// ===============================

function formatAcquisitionTime(time) {
    if (!time) {
        return '-';
    }

    const value = String(time).padStart(4, '0');

    let hour = parseInt(value.substring(0, 2), 10);
    const minute = value.substring(2, 4);

    // Konversi UTC → WIB
    hour += 7;

    // Jika melewati 24:00, kembali ke 00:00
    if (hour >= 24) {
        hour -= 24;
    }

    return `${String(hour).padStart(2, '0')}:${minute} WIB`;
}

// ===============================
// KLASIFIKASI HOTSPOT
// ===============================

function getHotspotLevel(confidence, frp) {

    const conf = parseFloat(confidence) || 0;
    const power = parseFloat(frp) || 0;

    // HOTSPOT TINGGI
    if (conf >= 80 || power >= 30) {

        return {
            level: 'Tinggi',
            class: 'high',
            color: '#dc2626',
            radius: 7
        };
    }

    // HOTSPOT SEDANG
    if (conf >= 50 || power >= 10) {

        return {
            level: 'Sedang',
            class: 'medium',
            color: '#f97316',
            radius: 6
        };
    }

    // HOTSPOT RENDAH
    return {
        level: 'Rendah',
        class: 'low',
        color: '#16a34a',
        radius: 5
    };
}

// ===============================
// BASEMAP
// ===============================

const osmLayer = L.tileLayer(
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    {
        attribution: '&copy; OpenStreetMap contributors'
    }
);

const satelliteLayer = L.tileLayer(
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    {
        attribution: 'Tiles &copy; Esri'
    }
);

const terrainLayer = L.tileLayer(
    'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    {
        attribution: '&copy; OpenTopoMap contributors'
    }
);

// Default basemap
satelliteLayer.addTo(map);

// ===============================
// BOUNDARY BANGKA BELITUNG
// ===============================

fetch('/gis/boundary')
    .then(response => {

        if (!response.ok) {
            throw new Error(
                'Gagal mengambil boundary Bangka Belitung.'
            );
        }

        return response.json();
    })
    .then(geojson => {

        console.log(
            'Boundary Babel:',
            geojson
        );

        L.geoJSON(geojson, {

            style: {
                color: '#f97316',
                weight: 3,
                opacity: 1,
                fillColor: '#f97316',
                fillOpacity: 0.05
            },

            onEachFeature: function (
                feature,
                layer
            ) {

                const properties =
                    feature.properties ?? {};

                const region =
                    properties.namobj ??
                    properties.wadmkk ??
                    '-';

                layer.bindPopup(`
                    <div style="
                        min-width: 180px;
                        font-family: Arial, sans-serif;
                    ">

                        <h3 style="
                            margin: 0 0 8px 0;
                        ">
                            🗺️ Wilayah Administrasi
                        </h3>

                        <b>Wilayah:</b>
                        ${region}

                    </div>
                `);
            }

        }).addTo(boundaryLayer);

        console.log(
            'Boundary Babel berhasil ditampilkan.'
        );

    })
    .catch(error => {

        console.error(
            'Error boundary:',
            error
        );

    });

// ===============================
// LAYER GROUP
// ===============================

// Layer kejadian kebakaran
const fireIncidentLayer = L.layerGroup();

// Layer hotspot NASA FIRMS
const hotspotLayer = L.layerGroup().addTo(map);

// Layer pos Damkar
const fireStationLayer = L.layerGroup();

// Layer boundary Babel
const boundaryLayer = L.layerGroup().addTo(map);


// ===============================
// CUSTOM ICON
// ===============================

const fireIcon = L.divIcon({
    html: '🔥',
    className: 'fire-icon',
    iconSize: [40, 40],
    iconAnchor: [20, 20],
    popupAnchor: [0, -20]
});

const hotspotIcon = L.divIcon({
    html: '🛰️',
    className: 'hotspot-icon',
    iconSize: [40, 40],
    iconAnchor: [20, 20],
    popupAnchor: [0, -20]
});

const fireStationIcon = L.divIcon({
    html: '🚒',
    className: 'fire-station-icon',
    iconSize: [40, 40],
    iconAnchor: [20, 20],
    popupAnchor: [0, -20]
});


// ===============================
// DATA DUMMY KEBAKARAN
// ===============================

L.marker([-2.1316, 106.1169], {
    icon: fireIcon
})
    .bindPopup(`
        <b>🔥 Kebakaran Rumah</b><br>
        Lokasi: Pangkalpinang<br>
        Status: Diproses
    `)
    .addTo(fireIncidentLayer);


L.marker([-2.5088, 106.4502], {
    icon: fireIcon
})
    .bindPopup(`
        <b>🔥 Kebakaran Lahan</b><br>
        Lokasi: Bangka Selatan<br>
        Status: Selesai
    `)
    .addTo(fireIncidentLayer);


L.marker([-2.0667, 105.1833], {
    icon: fireIcon
})
    .bindPopup(`
        <b>🔥 Kebakaran Gedung</b><br>
        Lokasi: Bangka Barat<br>
        Status: Menunggu
    `)
    .addTo(fireIncidentLayer);


// ===============================
// HOTSPOT NASA FIRMS
// ===============================

fetch('/gis/hotspots')
    .then(response => {

        if (!response.ok) {
            throw new Error(
                'Gagal mengambil data hotspot dari server.'
            );
        }

        return response.json();
    })
    .then(hotspots => {

        console.log(
            'NASA FIRMS Hotspots:',
            hotspots
        );

        hotspots.forEach(hotspot => {

            const latitude = parseFloat(
                hotspot.latitude
            );

            const longitude = parseFloat(
                hotspot.longitude
            );

            // Validasi koordinat
            if (
                Number.isNaN(latitude) ||
                Number.isNaN(longitude)
            ) {
                return;
            }


            // ===============================
            // MARKER HOTSPOT
            // ===============================

            const hotspotLevel = getHotspotLevel(
                hotspot.confidence,
                hotspot.frp
            );

            const marker = L.circleMarker(
                [latitude, longitude],
                {
                    radius: hotspotLevel.radius,

                    fillColor: hotspotLevel.color,

                    color: '#ffffff',

                    weight: 2,

                    opacity: 1,

                    fillOpacity: 0.85
                }
            );

            // ===============================
            // POPUP HOTSPOT
            // ===============================

            marker.bindPopup(`
            <div class="hotspot-popup">

                <h3 class="hotspot-popup-title">
                    🔥 Hotspot Terdeteksi
                </h3>

                <div class="hotspot-risk hotspot-risk-${hotspotLevel.class}">
                    Risiko ${hotspotLevel.level}
                </div>

                <b>Wilayah:</b>
                ${hotspot.region ?? '-'}
                <br>

                <b>Sumber:</b>
                ${hotspot.source ?? '-'}
                <br>

                <b>Satelit:</b>
                ${hotspot.satellite ?? '-'}
                <br>

                <b>Confidence:</b>
                ${hotspot.confidence ?? '-'}
                <br>

                <b>FRP:</b>
                ${hotspot.frp ?? '-'} MW
                <br>

                <b>Tanggal:</b>
                ${
                    hotspot.acq_date
                        ? new Date(
                            hotspot.acq_date
                        ).toLocaleDateString(
                            'id-ID',
                            {
                                day: '2-digit',
                                month: 'long',
                                year: 'numeric'
                            }
                        )
                        : '-'
                }
                <br>

                <b>Waktu Akuisisi:</b>
                ${formatAcquisitionTime(
                    hotspot.acq_time
                )}
                <br>

                <b>Koordinat:</b>
                ${latitude},
                ${longitude}

            </div>
        `);


            // Tambahkan ke layer hotspot
            marker.addTo(hotspotLayer);

        });


        console.log(
            `Berhasil menampilkan ${hotspots.length} hotspot.`
        );

    })
    .catch(error => {

        console.error(
            'Error hotspot:',
            error
        );

    });


// ===============================
// DATA DUMMY POS DAMKAR
// ===============================

L.marker([-2.1310, 106.1100], {
    icon: fireStationIcon
})
    .bindPopup(`
        <b>🚒 Pos Damkar Pangkalpinang</b><br>
        Status: Aktif
    `)
    .addTo(fireStationLayer);


L.marker([-2.0670, 105.1900], {
    icon: fireStationIcon
})
    .bindPopup(`
        <b>🚒 Pos Damkar Muntok</b><br>
        Status: Aktif
    `)
    .addTo(fireStationLayer);


// ===============================
// TAMPILKAN LAYER DEFAULT
// ===============================

fireIncidentLayer.addTo(map);
hotspotLayer.addTo(map);
fireStationLayer.addTo(map);


// ===============================
// LAYER CONTROL
// ===============================

const baseMaps = {
    '🗺️ Street': osmLayer,
    '🛰️ Satellite': satelliteLayer,
    '⛰️ Terrain': terrainLayer
};

const overlayLayers = {
    '🔥 Kejadian Kebakaran': fireIncidentLayer,
    '🛰️ Hotspot NASA FIRMS': hotspotLayer,
    '🚒 Pos Damkar': fireStationLayer,
    '🗺️ Batas Wilayah Babel': boundaryLayer
};

L.control.layers(
    baseMaps,
    overlayLayers
).addTo(map);

// ===============================
// LEGENDA HOTSPOT
// ===============================

const hotspotLegend = L.control({
    position: 'bottomright'
});

hotspotLegend.onAdd = function () {

    const div = L.DomUtil.create(
        'div',
        'hotspot-legend'
    );

    div.innerHTML = `
        <div class="hotspot-legend-title">
            🔥 Tingkat Hotspot
        </div>

        <div class="hotspot-legend-item">
            <span class="hotspot-legend-dot hotspot-legend-low">
                ●
            </span>
            Rendah
        </div>

        <div class="hotspot-legend-item">
            <span class="hotspot-legend-dot hotspot-legend-medium">
                ●
            </span>
            Sedang
        </div>

        <div class="hotspot-legend-item">
            <span class="hotspot-legend-dot hotspot-legend-high">
                ●
            </span>
            Tinggi
        </div>
    `;

    return div;
};

hotspotLegend.addTo(map);