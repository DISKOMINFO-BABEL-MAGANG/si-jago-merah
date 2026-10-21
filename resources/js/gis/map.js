const map = L.map('map').setView([-2.5, 106.5], 8);

// ===============================
// LAYER GROUP
// ===============================

const fireIncidentLayer  = L.layerGroup();
const nasaHotspotLayer   = L.layerGroup().addTo(map);
const himawariHotspotLayer = L.layerGroup().addTo(map);
const fireStationLayer   = L.layerGroup();
const boundaryLayer      = L.layerGroup().addTo(map);

// ===============================
// UTILITAS UMUM
// ===============================

function escapeHtml(value) {
    return String(value ?? '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#39;');
}

function csrfToken() {
    const meta = document.querySelector('meta[name="csrf-token"]');

    return meta ? meta.getAttribute('content') : '';
}

// ===============================
// KONFIGURASI SATELIT
// ===============================
// key = nilai kolom "source" di database

const SATELLITES = [
    { key: 'MODIS_NRT', label: 'NASA-MODIS' },
    { key: 'VIIRS_SNPP_NRT', label: 'NASA-SNPP' },
    { key: 'VIIRS_NOAA20_NRT', label: 'NASA-NOAA20' }
];

function satelliteLabel(source) {
    const found = SATELLITES.find(item => item.key === source);

    return found ? found.label : (source ?? '-');
}

// ===============================
// NORMALISASI CONFIDENCE
// ===============================
// VIIRS : l / n / h  (low / nominal / high)
// MODIS : angka 0-100
// Pemetaan mengikuti SiPongi: low 0-29, medium 30-79, high 80-100

function normalizeConfidence(confidence) {
    if (confidence === null || confidence === undefined || confidence === '') {
        return 'low';
    }

    const value = String(confidence).trim().toLowerCase();

    if (['l', 'low'].includes(value)) return 'low';
    if (['n', 'nominal', 'm', 'medium'].includes(value)) return 'medium';
    if (['h', 'high'].includes(value)) return 'high';

    const number = parseFloat(value);

    if (!Number.isNaN(number)) {
        if (number >= 80) return 'high';
        if (number >= 30) return 'medium';
        return 'low';
    }

    return 'low';
}

function getHotspotLevel(confidence) {
    const level = normalizeConfidence(confidence);

    const levels = {
        high: { key: 'high', level: 'Tinggi', class: 'high', color: '#dc2626', radius: 7 },
        medium: { key: 'medium', level: 'Sedang', class: 'medium', color: '#eab308', radius: 6 },
        low: { key: 'low', level: 'Rendah', class: 'low', color: '#16a34a', radius: 5 }
    };

    return levels[level];
}

// ===============================
// FORMAT WAKTU (UTC -> WIB)
// ===============================

function toUtcDate(acqDate, acqTime) {
    if (!acqDate || acqTime === null || acqTime === undefined) {
        return null;
    }

    const datePart = String(acqDate).substring(0, 10);
    const raw = String(acqTime).trim();

    let hours;
    let minutes;

    if (raw.includes(':')) {
        // Format "05:53:00"
        [hours, minutes] = raw.split(':');
    } else {
        // Format "553" atau "0553"
        const padded = raw.padStart(4, '0');
        hours = padded.substring(0, 2);
        minutes = padded.substring(2, 4);
    }

    const utc = new Date(
        `${datePart}T${hours.padStart(2, '0')}:${minutes.padStart(2, '0')}:00Z`
    );

    return Number.isNaN(utc.getTime()) ? null : utc;
}

function formatWIB(acqDate, acqTime) {
    const date = toUtcDate(acqDate, acqTime);

    if (!date) {
        return '-';
    }

    return date.toLocaleString('id-ID', {
        timeZone: 'Asia/Jakarta',
        day: '2-digit',
        month: 'long',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
    }) + ' WIB';
}

// Tanggal WIB format YYYY-MM-DD
function wibDateString(date) {
    return date.toLocaleDateString('sv-SE', { timeZone: 'Asia/Jakarta' });
}

// Tanggal WIB, digeser n hari dari sekarang
function wibDateOffset(daysAgo) {
    return wibDateString(new Date(Date.now() - daysAgo * 24 * 60 * 60 * 1000));
}

// ===============================
// BASEMAP
// ===============================

const osmLayer = L.tileLayer(
    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    { attribution: '&copy; OpenStreetMap contributors' }
);

const satelliteLayer = L.tileLayer(
    'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
    { attribution: 'Tiles &copy; Esri' }
);

const terrainLayer = L.tileLayer(
    'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
    { attribution: '&copy; OpenTopoMap contributors' }
);

satelliteLayer.addTo(map);

// ===============================
// BOUNDARY BANGKA BELITUNG
// ===============================

fetch('/gis/boundary')
    .then(response => {
        if (!response.ok) {
            throw new Error('Gagal mengambil boundary Bangka Belitung.');
        }

        return response.json();
    })
    .then(geojson => {
        L.geoJSON(geojson, {
            style: {
                color: '#f97316',
                weight: 3,
                opacity: 1,
                fillColor: '#f97316',
                fillOpacity: 0.05
            },

            onEachFeature: function (feature, layer) {
                const properties = feature.properties ?? {};

                const region =
                    properties.namobj ??
                    properties.wadmkk ??
                    '-';

                layer.bindPopup(`
                    <div style="min-width: 180px; font-family: Arial, sans-serif;">
                        <h3 style="margin: 0 0 8px 0;">
                            🗺️ Wilayah Administrasi
                        </h3>
                        <b>Wilayah:</b> ${escapeHtml(region)}
                    </div>
                `);
            }
        }).addTo(boundaryLayer);
    })
    .catch(error => {
        console.error('Error boundary:', error);
    });

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

const fireStationIcon = L.divIcon({
    html: '🚒',
    className: 'fire-station-icon',
    iconSize: [40, 40],
    iconAnchor: [20, 20],
    popupAnchor: [0, -20]
});

// ===============================
// KEJADIAN KEBAKARAN (dari database)
// ===============================
// Data berasal dari tabel `kejadian` + `detail_kebakaran`
// lewat endpoint GET /gis/kejadian.

const JENIS_KEBAKARAN = {
    lahan: 'Lahan',
    hutan: 'Hutan',
    rumah: 'Rumah'
};

function incidentPopupHtml(incident) {
    const jenis = JENIS_KEBAKARAN[incident.objek_terbakar] ?? 'Tidak diketahui';

    const luas =
        incident.luas_area_ha !== null && incident.luas_area_ha !== undefined
            ? `${Number(incident.luas_area_ha).toLocaleString('id-ID')} ha`
            : '-';

    const waktu = incident.tanggal
        ? `${incident.tanggal}${incident.waktu ? ' ' + String(incident.waktu).substring(0, 5) : ''} WIB`
        : '-';

    const keterangan = incident.keterangan
        ? escapeHtml(incident.keterangan).replace(/\n/g, '<br>')
        : '-';

    return `
        <div style="min-width: 200px; max-width: 260px; font-family: Arial, sans-serif;">
            <h3 style="margin: 0 0 8px 0;">🔥 Kebakaran ${escapeHtml(jenis)}</h3>

            <b>Waktu:</b> ${escapeHtml(waktu)}<br>
            <b>Luas terdampak:</b> ${escapeHtml(luas)}<br>
            <b>Korban jiwa:</b> ${escapeHtml(incident.korban_meninggal ?? 0)} orang<br>
            <b>Keterangan:</b> ${keterangan}<br>
            <b>Koordinat:</b> ${escapeHtml(Number(incident.latitude).toFixed(6))}, ${escapeHtml(Number(incident.longitude).toFixed(6))}
        </div>
    `;
}

function addIncidentMarker(incident) {
    const latitude = parseFloat(incident.latitude);
    const longitude = parseFloat(incident.longitude);

    if (Number.isNaN(latitude) || Number.isNaN(longitude)) {
        return null;
    }

    return L.marker([latitude, longitude], { icon: fireIcon })
        .bindPopup(incidentPopupHtml(incident))
        .addTo(fireIncidentLayer);
}

function loadIncidents() {
    fetch('/gis/kejadian', { headers: { Accept: 'application/json' } })
        .then(response => {
            if (!response.ok) {
                throw new Error('Gagal mengambil data kejadian kebakaran.');
            }

            return response.json();
        })
        .then(incidents => {
            fireIncidentLayer.clearLayers();
            incidents.forEach(addIncidentMarker);
        })
        .catch(error => {
            console.error('Error kejadian:', error);
        });
}

loadIncidents();

// ===============================
// STYLE: TANDAI LOKASI KEBAKARAN
// ===============================

const markStyle = document.createElement('style');

markStyle.textContent = `
    .mk-button {
        padding: 9px 12px;
        border: none;
        border-radius: 8px;
        background: #b91c1c;
        color: #ffffff;
        font-family: Arial, sans-serif;
        font-size: 12px;
        font-weight: bold;
        cursor: pointer;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.35);
    }
    .mk-button:hover { background: #991b1b; }
    .mk-button.mk-active { background: #374151; }
    .mk-hint {
        margin-top: 6px;
        max-width: 230px;
        padding: 7px 9px;
        border-radius: 8px;
        background: #ffffff;
        color: #1f2937;
        font-family: Arial, sans-serif;
        font-size: 11px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
    }
    .mk-crosshair { cursor: crosshair !important; }
    .mk-crosshair .leaflet-interactive { cursor: crosshair; }

    /* Saat menandai lokasi, polygon batas wilayah dan lingkaran hotspot
       tidak menangkap klik, jadi popup-nya tidak muncul dan klik
       langsung sampai ke peta. */
    .mk-crosshair .leaflet-overlay-pane path.leaflet-interactive {
        pointer-events: none !important;
    }

    .mk-form {
        min-width: 230px;
        font-family: Arial, sans-serif;
        font-size: 12px;
        color: #1f2937;
    }
    .mk-form-title {
        margin-bottom: 4px;
        font-size: 14px;
        font-weight: bold;
    }
    .mk-coords {
        margin-bottom: 8px;
        color: #6b7280;
        font-size: 11px;
    }
    .mk-form label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
        color: #374151;
    }
    .mk-form label small {
        font-weight: normal;
        color: #6b7280;
    }
    .mk-form select,
    .mk-form input,
    .mk-form textarea {
        display: block;
        width: 100%;
        box-sizing: border-box;
        margin-top: 3px;
        padding: 6px 8px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-family: inherit;
        font-size: 12px;
        font-weight: normal;
        background: #ffffff;
    }
    .mk-form textarea { resize: vertical; }
    .mk-error {
        min-height: 14px;
        margin-bottom: 6px;
        color: #b91c1c;
        font-size: 11px;
    }
    .mk-actions { display: flex; gap: 6px; }
    .mk-btn {
        flex: 1;
        padding: 8px 0;
        border: none;
        border-radius: 6px;
        background: #e5e7eb;
        color: #374151;
        font-size: 12px;
        font-weight: bold;
        cursor: pointer;
    }
    .mk-btn:hover { background: #d1d5db; }
    .mk-btn-primary { background: #b91c1c; color: #ffffff; }
    .mk-btn-primary:hover { background: #991b1b; }
    .mk-btn:disabled { opacity: 0.6; cursor: default; }

    .mk-toast {
        position: fixed;
        left: 50%;
        bottom: 24px;
        z-index: 10000;
        transform: translateX(-50%);
        padding: 10px 16px;
        border-radius: 8px;
        background: #111827;
        color: #ffffff;
        font-family: Arial, sans-serif;
        font-size: 13px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.4);
    }
`;

document.head.appendChild(markStyle);

// ===============================
// TANDAI LOKASI KEBAKARAN
// ===============================

let markMode = false;
let draftMarker = null;
let draftCoordsEl = null;

function showToast(text) {
    const toast = document.createElement('div');

    toast.className = 'mk-toast';
    toast.textContent = text;

    document.body.appendChild(toast);

    setTimeout(() => toast.remove(), 3500);
}

function removeDraft() {
    if (draftMarker) {
        map.removeLayer(draftMarker);
        draftMarker = null;
        draftCoordsEl = null;
    }
}

function setMarkMode(active) {
    markMode = active;

    map.getContainer().classList.toggle('mk-crosshair', active);

    const button = document.getElementById('mk-toggle');
    const hint = document.getElementById('mk-hint');

    if (button) {
        button.textContent = active ? '✖ Batal Menandai' : '📍 Tandai Lokasi Kebakaran';
        button.classList.toggle('mk-active', active);
    }

    if (hint) {
        hint.style.display = active ? 'block' : 'none';
    }

    if (active) {
        // Tutup popup lain yang sedang terbuka (mis. Wilayah Administrasi)
        map.closePopup();
    } else {
        removeDraft();
    }
}

function updateDraftCoords() {
    if (!draftMarker || !draftCoordsEl) {
        return;
    }

    const { lat, lng } = draftMarker.getLatLng();

    draftCoordsEl.textContent = `Koordinat: ${lat.toFixed(6)}, ${lng.toFixed(6)}`;
}

function buildIncidentForm() {
    const form = L.DomUtil.create('div', 'mk-form');

    form.innerHTML = `
        <div class="mk-form-title">🔥 Data Kejadian Kebakaran</div>
        <div class="mk-coords" data-role="coords"></div>

        <label>
            Jenis Kebakaran
            <select data-role="jenis">
                <option value="">-- Pilih jenis --</option>
                <option value="lahan">Lahan</option>
                <option value="hutan">Hutan</option>
                <option value="rumah">Rumah</option>
            </select>
        </label>

        <label>
            Luas Area Terdampak (ha)
            <input type="number" data-role="luas" min="0" step="0.01" placeholder="Contoh: 2.5">
        </label>

        <label>
            Jumlah Korban Jiwa <small>(isi jika ada)</small>
            <input type="number" data-role="korban" min="0" step="1" placeholder="0">
        </label>

        <label>
            Keterangan Tambahan
            <textarea data-role="keterangan" rows="3" maxlength="2000"
                placeholder="Kondisi di lokasi, penyebab, dan lainnya"></textarea>
        </label>

        <div class="mk-error" data-role="error"></div>

        <div class="mk-actions">
            <button type="button" class="mk-btn mk-btn-primary" data-role="save">Simpan</button>
            <button type="button" class="mk-btn" data-role="cancel">Batal</button>
        </div>
    `;

    const field = role => form.querySelector(`[data-role="${role}"]`);

    draftCoordsEl = field('coords');

    const errorEl = field('error');
    const saveButton = field('save');

    field('cancel').addEventListener('click', () => setMarkMode(false));

    saveButton.addEventListener('click', async () => {
        errorEl.textContent = '';

        const jenis = field('jenis').value;
        const luasRaw = field('luas').value.trim();
        const korbanRaw = field('korban').value.trim();
        const keterangan = field('keterangan').value.trim();

        if (!jenis) {
            errorEl.textContent = 'Pilih jenis kebakaran.';
            return;
        }

        if (luasRaw !== '' && (Number.isNaN(Number(luasRaw)) || Number(luasRaw) < 0)) {
            errorEl.textContent = 'Luas area harus berupa angka 0 atau lebih.';
            return;
        }

        if (korbanRaw !== '' && (!/^\d+$/.test(korbanRaw))) {
            errorEl.textContent = 'Jumlah korban jiwa harus bilangan bulat 0 atau lebih.';
            return;
        }

        const { lat, lng } = draftMarker.getLatLng();

        const payload = {
            latitude: lat,
            longitude: lng,
            objek_terbakar: jenis,
            luas_area_ha: luasRaw === '' ? null : Number(luasRaw),
            korban_meninggal: korbanRaw === '' ? 0 : parseInt(korbanRaw, 10),
            keterangan: keterangan === '' ? null : keterangan
        };

        saveButton.disabled = true;
        saveButton.textContent = 'Menyimpan...';

        try {
            const response = await fetch('/gis/kejadian', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    Accept: 'application/json',
                    'X-Requested-With': 'XMLHttpRequest',
                    'X-CSRF-TOKEN': csrfToken()
                },
                body: JSON.stringify(payload)
            });

            const result = await response.json().catch(() => ({}));

            if (response.status === 422) {
                const firstError = Object.values(result.errors ?? {})[0];

                errorEl.textContent = firstError
                    ? firstError[0]
                    : 'Data tidak valid. Periksa kembali isian.';

                return;
            }

            if (response.status === 419) {
                errorEl.textContent = 'Sesi habis. Muat ulang halaman lalu coba lagi.';
                return;
            }

            if (!response.ok) {
                throw new Error(result.message || 'Gagal menyimpan kejadian.');
            }

            const marker = addIncidentMarker(result);

            setMarkMode(false);

            if (marker) {
                marker.openPopup();
            }

            showToast('Kejadian kebakaran berhasil disimpan.');
        } catch (error) {
            console.error('Error simpan kejadian:', error);
            errorEl.textContent = error.message || 'Terjadi kesalahan saat menyimpan.';
        } finally {
            // Tombol hanya perlu dipulihkan jika form masih ada
            saveButton.disabled = false;
            saveButton.textContent = 'Simpan';
        }
    });

    return form;
}

function placeDraft(latlng) {
    // Sudah ada titik: cukup pindahkan
    if (draftMarker) {
        draftMarker.setLatLng(latlng);
        updateDraftCoords();
        draftMarker.openPopup();
        return;
    }

    draftMarker = L.marker(latlng, {
        icon: fireIcon,
        draggable: true
    });

    draftMarker.bindPopup(buildIncidentForm(), {
        closeOnClick: false,
        autoClose: false,
        closeButton: false,
        minWidth: 240,
        maxWidth: 280
    });

    draftMarker.on('drag', updateDraftCoords);
    draftMarker.on('dragend', updateDraftCoords);

    draftMarker.addTo(map);
    updateDraftCoords();
    draftMarker.openPopup();
}

map.on('click', event => {
    if (markMode) {
        placeDraft(event.latlng);
    }
});

document.addEventListener('keydown', event => {
    if (event.key === 'Escape' && markMode) {
        setMarkMode(false);
    }
});

const markControl = L.control({ position: 'bottomleft' });

markControl.onAdd = function () {
    const div = L.DomUtil.create('div', 'mk-control');

    div.innerHTML = `
        <button type="button" class="mk-button" id="mk-toggle">
            📍 Tandai Lokasi Kebakaran
        </button>
        <div class="mk-hint" id="mk-hint" style="display: none;">
            Klik peta untuk menandai lokasi. Klik lagi atau seret titik
            untuk memindahkannya, lalu isi keterangan.
        </div>
    `;

    L.DomEvent.disableClickPropagation(div);

    return div;
};

markControl.addTo(map);

document.getElementById('mk-toggle').addEventListener('click', () => {
    setMarkMode(!markMode);
});

// ===============================
// STYLE PANEL FILTER (gaya SiPongi)
// ===============================

const filterStyle = document.createElement('style');

filterStyle.textContent = `
    .hs-panel {
        width: 270px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.35);
        font-family: Arial, sans-serif;
        font-size: 12px;
        color: #1f2937;
        overflow: hidden;
    }
    .hs-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 12px;
        background: #b91c1c;
        color: #ffffff;
        font-weight: bold;
        font-size: 13px;
        cursor: pointer;
        user-select: none;
    }
    .hs-body {
        padding: 12px;
        max-height: 70vh;
        overflow-y: auto;
    }
    .hs-body.hs-collapsed { display: none; }
    .hs-section { margin-bottom: 12px; }
    .hs-label {
        font-weight: bold;
        margin-bottom: 5px;
        color: #374151;
    }
    .hs-panel select,
    .hs-panel input[type="date"] {
        width: 100%;
        box-sizing: border-box;
        padding: 6px 8px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 12px;
        background: #ffffff;
    }
    .hs-custom-dates { margin-top: 6px; display: none; }
    .hs-custom-dates.hs-show { display: block; }
    .hs-custom-dates label { display: block; margin-bottom: 5px; }
    .hs-check {
        display: flex;
        align-items: center;
        gap: 7px;
        padding: 3px 0;
        cursor: pointer;
    }
    .hs-dot {
        display: inline-block;
        width: 11px;
        height: 11px;
        border-radius: 50%;
        border: 1px solid rgba(0, 0, 0, 0.25);
    }
    .hs-actions { display: flex; gap: 6px; }
    .hs-btn {
        flex: 1;
        padding: 8px 0;
        border: none;
        border-radius: 6px;
        font-size: 12px;
        font-weight: bold;
        cursor: pointer;
    }
    .hs-btn-primary { background: #b91c1c; color: #ffffff; }
    .hs-btn-primary:hover { background: #991b1b; }
    .hs-btn-secondary { background: #e5e7eb; color: #374151; }
    .hs-btn-secondary:hover { background: #d1d5db; }
    .hs-status {
        margin-top: 8px;
        color: #4b5563;
        font-size: 11px;
    }
    .hs-status.hs-error { color: #b91c1c; }
    .hs-summary {
        width: 100%;
        border-collapse: collapse;
        margin-top: 4px;
        font-size: 11px;
    }
    .hs-summary th,
    .hs-summary td {
        padding: 4px 3px;
        text-align: center;
        border-bottom: 1px solid #e5e7eb;
    }
    .hs-summary th:first-child,
    .hs-summary td:first-child { text-align: left; }
    .hs-summary tfoot td { font-weight: bold; border-bottom: none; }
    .hs-cell {
        display: inline-block;
        min-width: 22px;
        padding: 1px 5px;
        border-radius: 8px;
        color: #ffffff;
        font-weight: bold;
    }
    .hs-cell-low { background: #16a34a; }
    .hs-cell-medium { background: #eab308; color: #1f2937; }
    .hs-cell-high { background: #dc2626; }
`;

document.head.appendChild(filterStyle);

// ===============================
// STATE FILTER
// ===============================

const DEFAULT_FILTERS = {
    period: '24',        // jam terakhir, atau 'custom'
    start: wibDateOffset(0),
    end: wibDateOffset(0),
    satellites: SATELLITES.map(item => item.key),
    confidences: ['low', 'medium', 'high'],
    region: '',
    sources: ['nasa', 'himawari']    // sumber data aktif
};

let filters = JSON.parse(JSON.stringify(DEFAULT_FILTERS));

let allNasaHotspots     = [];
let allHimawariHotspots = [];
let hotspotRequestId    = 0;

function periodLabel() {
    if (filters.period === 'custom') {
        return filters.start === filters.end
            ? filters.start
            : `${filters.start} s/d ${filters.end}`;
    }

    const hours = parseInt(filters.period, 10);

    return hours % 24 === 0 && hours >= 48
        ? `${hours / 24} hari terakhir`
        : `${hours} jam terakhir`;
}

// Filter untuk hotspot NASA FIRMS
function passesNasaFilters(hotspot) {
    // Satelit
    if (!filters.satellites.includes(hotspot.source)) {
        return false;
    }

    // Confidence
    if (!filters.confidences.includes(normalizeConfidence(hotspot.confidence))) {
        return false;
    }

    // Kabupaten/kota
    if (filters.region && hotspot.region !== filters.region) {
        return false;
    }

    // Periode (filter klien-side jika ada data lintas hari)
    const utc = toUtcDate(hotspot.acq_date, hotspot.acq_time);

    if (!utc) {
        return false;
    }

    if (filters.period === 'custom') {
        const wibDate = wibDateString(utc);
        return wibDate >= filters.start && wibDate <= filters.end;
    }

    const hours = parseInt(filters.period, 10);

    return utc.getTime() >= Date.now() - hours * 60 * 60 * 1000;
}

// Filter untuk hotspot Himawari (hanya region & periode, tidak ada confidence/satelit)
function passesHimawariFilters(hotspot) {
    // Kabupaten/kota
    if (filters.region && hotspot.region !== filters.region) {
        return false;
    }

    const utc = toUtcDate(hotspot.acq_date, hotspot.acq_time);

    if (!utc) {
        return false;
    }

    if (filters.period === 'custom') {
        const wibDate = wibDateString(utc);
        return wibDate >= filters.start && wibDate <= filters.end;
    }

    const hours = parseInt(filters.period, 10);

    return utc.getTime() >= Date.now() - hours * 60 * 60 * 1000;
}

// ===============================
// RENDER HOTSPOT + RINGKASAN
// ===============================

function setStatus(text, isError = false) {
    const status = document.getElementById('hs-status');

    if (status) {
        status.textContent = text;
        status.classList.toggle('hs-error', isError);
    }
}

function renderSummary(nasaCounts, himawariCount) {
    const body = document.getElementById('hs-summary-body');
    const foot = document.getElementById('hs-summary-foot');

    if (!body || !foot) {
        return;
    }

    let totalLow = 0;
    let totalMedium = 0;
    let totalHigh = 0;

    body.innerHTML = '';

    // Baris NASA FIRMS (per satelit, ada confidence)
    SATELLITES.forEach(satellite => {
        const row = nasaCounts[satellite.key] ?? { low: 0, medium: 0, high: 0 };
        const total = row.low + row.medium + row.high;

        totalLow    += row.low;
        totalMedium += row.medium;
        totalHigh   += row.high;

        const tr = document.createElement('tr');

        tr.innerHTML = `
            <td>${satellite.label}</td>
            <td><span class="hs-cell hs-cell-low">${row.low}</span></td>
            <td><span class="hs-cell hs-cell-medium">${row.medium}</span></td>
            <td><span class="hs-cell hs-cell-high">${row.high}</span></td>
            <td>${total}</td>
        `;

        body.appendChild(tr);
    });

    // Baris Himawari (tidak ada confidence level)
    if (filters.sources.includes('himawari')) {
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>🛰️ Himawari</td>
            <td colspan="3" style="text-align:center">
                <span class="hs-cell" style="background:#7c3aed;">${himawariCount}</span>
            </td>
            <td>${himawariCount}</td>
        `;
        body.appendChild(tr);
    }

    foot.innerHTML = `
        <tr>
            <td>Total</td>
            <td>${totalLow}</td>
            <td>${totalMedium}</td>
            <td>${totalHigh}</td>
            <td>${totalLow + totalMedium + totalHigh + (filters.sources.includes('himawari') ? himawariCount : 0)}</td>
        </tr>
    `;
}

// ----- Render NASA FIRMS -----
function renderNasaHotspots() {
    nasaHotspotLayer.clearLayers();

    const counts = {};
    let displayed = 0;

    if (!filters.sources.includes('nasa')) {
        return { counts, displayed };
    }

    allNasaHotspots.forEach(hotspot => {
        if (!passesNasaFilters(hotspot)) {
            return;
        }

        const latitude  = parseFloat(hotspot.latitude);
        const longitude = parseFloat(hotspot.longitude);

        if (Number.isNaN(latitude) || Number.isNaN(longitude)) {
            return;
        }

        const hotspotLevel = getHotspotLevel(hotspot.confidence);

        // Hitung untuk ringkasan
        if (!counts[hotspot.source]) {
            counts[hotspot.source] = { low: 0, medium: 0, high: 0 };
        }

        counts[hotspot.source][hotspotLevel.key]++;

        const marker = L.circleMarker([latitude, longitude], {
            radius: hotspotLevel.radius,
            fillColor: hotspotLevel.color,
            color: '#ffffff',
            weight: 2,
            opacity: 1,
            fillOpacity: 0.85
        });

        marker.bindPopup(`
            <div class="hotspot-popup">

                <h3 class="hotspot-popup-title">
                    🔥 NASA FIRMS Hotspot
                </h3>

                <div class="hotspot-risk hotspot-risk-${hotspotLevel.class}">
                    Confidence ${hotspotLevel.level}
                </div>

                <b>Wilayah:</b>
                ${escapeHtml(hotspot.region ?? '-')}
                <br>

                <b>Sumber:</b>
                ${escapeHtml(satelliteLabel(hotspot.source))}
                <br>

                <b>Satelit:</b>
                ${escapeHtml(hotspot.satellite ?? '-')}
                <br>

                <b>Confidence:</b>
                ${escapeHtml(String(hotspot.confidence ?? '-'))}
                (${normalizeConfidence(hotspot.confidence)})
                <br>

                <b>FRP:</b>
                ${escapeHtml(String(hotspot.frp ?? '-'))} MW
                <br>

                <b>Waktu Deteksi:</b>
                ${formatWIB(hotspot.acq_date, hotspot.acq_time)}
                <br>

                <b>Koordinat:</b>
                ${latitude.toFixed(6)}, ${longitude.toFixed(6)}

            </div>
        `);

        marker.addTo(nasaHotspotLayer);
        displayed++;
    });

    return { counts, displayed };
}

// ----- Render Himawari -----
function renderHimawariHotspots() {
    himawariHotspotLayer.clearLayers();

    let displayed = 0;

    if (!filters.sources.includes('himawari')) {
        return displayed;
    }

    // Kelompokkan hotspot berdasarkan titik lokasi unik (toleransi ~11 meter)
    // agar observasi berulang setiap 10 menit tidak saling bertumpuk di peta
    const groups = new Map();

    allHimawariHotspots.forEach(hotspot => {
        if (!passesHimawariFilters(hotspot)) {
            return;
        }

        const latitude  = parseFloat(hotspot.latitude);
        const longitude = parseFloat(hotspot.longitude);

        if (Number.isNaN(latitude) || Number.isNaN(longitude)) {
            return;
        }

        const key = `${latitude.toFixed(4)}_${longitude.toFixed(4)}`;

        if (!groups.has(key)) {
            groups.set(key, []);
        }
        groups.get(key).push(hotspot);
    });

    groups.forEach(groupHotspots => {
        // Urutkan observasi dari yang terbaru ke terlama
        groupHotspots.sort((a, b) => {
            const timeA = `${a.acq_date || ''} ${a.acq_time || ''}`;
            const timeB = `${b.acq_date || ''} ${b.acq_time || ''}`;
            return timeB.localeCompare(timeA);
        });

        const latest = groupHotspots[0];
        const oldest = groupHotspots[groupHotspots.length - 1];
        const detectionCount = groupHotspots.length;

        const latitude  = parseFloat(latest.latitude);
        const longitude = parseFloat(latest.longitude);

        // Ambil BT07 tertinggi dari semua observasi di titik ini
        let maxBt07 = null;
        groupHotspots.forEach(h => {
            if (h.bt07 !== null && h.bt07 !== undefined) {
                const val = parseFloat(h.bt07);
                if (!Number.isNaN(val)) {
                    if (maxBt07 === null || val > maxBt07) {
                        maxBt07 = val;
                    }
                }
            }
        });

        // Warna ungu untuk membedakan dari NASA
        const marker = L.circleMarker([latitude, longitude], {
            radius: 7,
            fillColor: '#7c3aed',
            color: '#ffffff',
            weight: 2,
            opacity: 1,
            fillOpacity: 0.85
        });

        const bt07  = latest.bt07  !== null && latest.bt07  !== undefined ? Number(latest.bt07).toFixed(2)  + ' K' : '-';
        const bt14  = latest.bt14  !== null && latest.bt14  !== undefined ? Number(latest.bt14).toFixed(2)  + ' K' : '-';
        const diff  = latest.bt_difference !== null && latest.bt_difference !== undefined
            ? Number(latest.bt_difference).toFixed(2) + ' K'
            : '-';
        const pixel = latest.pixel_count ?? '-';

        const historyHtml = detectionCount > 1
            ? `
                <b>Frekuensi Terdeteksi:</b>
                <span style="font-weight:bold;color:#7c3aed">${detectionCount}x observasi</span>
                <br>
                <b>Deteksi Terakhir:</b>
                ${formatWIB(latest.acq_date, latest.acq_time)}
                <br>
                <b>Deteksi Pertama:</b>
                ${formatWIB(oldest.acq_date, oldest.acq_time)}
            `
            : `
                <b>Waktu Deteksi:</b>
                ${formatWIB(latest.acq_date, latest.acq_time)}
            `;

        const maxBt07Html = (maxBt07 !== null && latest.bt07 !== null && Math.abs(maxBt07 - parseFloat(latest.bt07)) > 0.05)
            ? ` (Maks: ${maxBt07.toFixed(2)} K)`
            : '';

        marker.bindPopup(`
            <div class="hotspot-popup">

                <h3 class="hotspot-popup-title" style="color:#7c3aed">
                    🛰️ Himawari Hotspot
                </h3>

                <div class="hotspot-risk" style="background:#7c3aed;color:#fff;padding:3px 8px;border-radius:4px;display:inline-block;margin-bottom:6px">
                    ${escapeHtml(latest.source ?? 'HIMAWARI')}
                </div>

                <br>

                <b>Wilayah:</b>
                ${escapeHtml(latest.region ?? '-')}
                <br>

                <b>Satelit:</b>
                ${escapeHtml(latest.satellite ?? '-')}
                <br>

                ${historyHtml}
                <br>

                <b>BT Ch.07 (3.9µm):</b>
                ${escapeHtml(bt07)}${maxBt07Html}
                <br>

                <b>BT Ch.14 (11µm):</b>
                ${escapeHtml(bt14)}
                <br>

                <b>Selisih BT (07-14):</b>
                ${escapeHtml(diff)}
                <br>

                <b>Jumlah Piksel:</b>
                ${escapeHtml(String(pixel))}
                <br>

                <b>Koordinat:</b>
                ${latitude.toFixed(6)}, ${longitude.toFixed(6)}

            </div>
        `);

        marker.addTo(himawariHotspotLayer);
        displayed++;
    });

    return displayed;
}

// ----- Render gabungan & ringkasan -----
function renderHotspots() {
    const { counts, displayed: nasaCount } = renderNasaHotspots();
    const himawariCount = renderHimawariHotspots();
    const total = nasaCount + himawariCount;

    renderSummary(counts, himawariCount);
    setStatus(`${total} hotspot • ${periodLabel()}`);
}

// ===============================
// DAFTAR KABUPATEN/KOTA (dari data)
// ===============================

function updateRegionOptions() {
    const select = document.getElementById('hs-region');

    if (!select) {
        return;
    }

    // Gabungkan region dari kedua sumber
    const regions = [...new Set(
        [...allNasaHotspots, ...allHimawariHotspots]
            .map(hotspot => hotspot.region)
            .filter(region => region)
    )].sort();

    select.innerHTML = '';

    const all = document.createElement('option');
    all.value = '';
    all.textContent = 'Semua Kabupaten/Kota';
    select.appendChild(all);

    regions.forEach(region => {
        const option = document.createElement('option');
        option.value = region;
        option.textContent = region;
        select.appendChild(option);
    });

    // Pertahankan pilihan sebelumnya jika masih ada
    select.value = regions.includes(filters.region) ? filters.region : '';
    filters.region = select.value;
}

// ===============================
// AMBIL DATA DARI SERVER
// ===============================

function loadHotspots() {
    const requestId = ++hotspotRequestId;

    let start;
    let end;

    if (filters.period === 'custom') {
        start = filters.start;
        end = filters.end;
    } else {
        // Ambil rentang tanggal WIB yang mencakup N jam terakhir
        const days = Math.ceil(parseInt(filters.period, 10) / 24);
        start = wibDateOffset(days);
        end = wibDateOffset(0);
    }

    const params = new URLSearchParams({ start, end });

    setStatus('Memuat data...');

    fetch(`/gis/hotspots?${params.toString()}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Gagal mengambil data hotspot dari server.');
            }

            return response.json();
        })
        .then(data => {
            // Abaikan respons lama jika sudah ada request yang lebih baru
            if (requestId !== hotspotRequestId) {
                return;
            }

            // Endpoint mengembalikan { nasa: [...], himawari: [...] }
            allNasaHotspots     = Array.isArray(data.nasa)     ? data.nasa     : [];
            allHimawariHotspots = Array.isArray(data.himawari) ? data.himawari : [];

            updateRegionOptions();
            renderHotspots();
        })
        .catch(error => {
            console.error('Error hotspot:', error);
            setStatus('Gagal memuat data hotspot.', true);
        });
}

// ===============================
// PANEL FILTER
// ===============================

const filterControl = L.control({ position: 'topleft' });

filterControl.onAdd = function () {
    const div = L.DomUtil.create('div', 'hs-panel');

    const satelliteChecks = SATELLITES.map(satellite => `
        <label class="hs-check">
            <input type="checkbox" name="hs-satellite" value="${satellite.key}" checked>
            <span>${satellite.label}</span>
        </label>
    `).join('');

    const sourceChecks = `
        <label class="hs-check">
            <input type="checkbox" name="hs-source" value="nasa" checked>
            <span>🔴 NASA FIRMS</span>
        </label>
        <label class="hs-check">
            <input type="checkbox" name="hs-source" value="himawari" checked>
            <span>🟣 Himawari</span>
        </label>
    `;

    div.innerHTML = `
        <div class="hs-header" id="hs-toggle">
            <span>🔥 Filter Hotspot</span>
            <span id="hs-toggle-icon">▾</span>
        </div>

        <div class="hs-body" id="hs-body">

            <div class="hs-section">
                <div class="hs-label">Periode</div>
                <select id="hs-period">
                    <option value="24" selected>24 Jam Terakhir</option>
                    <option value="48">48 Jam Terakhir</option>
                    <option value="72">72 Jam Terakhir</option>
                    <option value="168">7 Hari Terakhir</option>
                    <option value="custom">Pilih Tanggal</option>
                </select>

                <div class="hs-custom-dates" id="hs-custom-dates">
                    <label>
                        Dari (WIB)
                        <input type="date" id="hs-start">
                    </label>
                    <label>
                        Sampai (WIB)
                        <input type="date" id="hs-end">
                    </label>
                </div>
            </div>

            <div class="hs-section">
                <div class="hs-label">Kabupaten/Kota</div>
                <select id="hs-region">
                    <option value="">Semua Kabupaten/Kota</option>
                </select>
            </div>

            <div class="hs-section">
                <div class="hs-label">Sumber Data</div>
                ${sourceChecks}
            </div>

            <div class="hs-section" id="hs-nasa-section">
                <div class="hs-label">Satelit NASA FIRMS</div>
                ${satelliteChecks}
            </div>

            <div class="hs-section">
                <div class="hs-label">Confidence</div>

                <label class="hs-check">
                    <input type="checkbox" name="hs-confidence" value="low" checked>
                    <span class="hs-dot" style="background:#16a34a"></span>
                    <span>Low (0-29)</span>
                </label>

                <label class="hs-check">
                    <input type="checkbox" name="hs-confidence" value="medium" checked>
                    <span class="hs-dot" style="background:#eab308"></span>
                    <span>Medium (30-79)</span>
                </label>

                <label class="hs-check">
                    <input type="checkbox" name="hs-confidence" value="high" checked>
                    <span class="hs-dot" style="background:#dc2626"></span>
                    <span>High (80-100)</span>
                </label>
            </div>

            <div class="hs-actions">
                <button type="button" class="hs-btn hs-btn-primary" id="hs-apply">Pilih</button>
                <button type="button" class="hs-btn hs-btn-secondary" id="hs-reset">Reset</button>
            </div>

            <div class="hs-status" id="hs-status"></div>

            <div class="hs-section" style="margin-top: 12px; margin-bottom: 0;">
                <div class="hs-label">Info Titik Hotspot</div>
                <table class="hs-summary">
                    <thead>
                        <tr>
                            <th>Satelit</th>
                            <th><span class="hs-dot" style="background:#16a34a"></span></th>
                            <th><span class="hs-dot" style="background:#eab308"></span></th>
                            <th><span class="hs-dot" style="background:#dc2626"></span></th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody id="hs-summary-body"></tbody>
                    <tfoot id="hs-summary-foot"></tfoot>
                </table>
            </div>

        </div>
    `;

    // Agar klik/scroll di panel tidak menggeser peta
    L.DomEvent.disableClickPropagation(div);
    L.DomEvent.disableScrollPropagation(div);

    return div;
};

filterControl.addTo(map);

// ===============================
// EVENT PANEL FILTER
// ===============================

function readFiltersFromForm() {
    const period = document.getElementById('hs-period').value;

    return {
        period,
        start: document.getElementById('hs-start').value,
        end: document.getElementById('hs-end').value,
        satellites: [...document.querySelectorAll('input[name="hs-satellite"]:checked')]
            .map(input => input.value),
        confidences: [...document.querySelectorAll('input[name="hs-confidence"]:checked')]
            .map(input => input.value),
        region: document.getElementById('hs-region').value,
        sources: [...document.querySelectorAll('input[name="hs-source"]:checked')]
            .map(input => input.value)
    };
}

function writeFiltersToForm() {
    document.getElementById('hs-period').value = filters.period;
    document.getElementById('hs-start').value = filters.start;
    document.getElementById('hs-end').value = filters.end;
    document.getElementById('hs-region').value = filters.region;

    document.querySelectorAll('input[name="hs-satellite"]').forEach(input => {
        input.checked = filters.satellites.includes(input.value);
    });

    document.querySelectorAll('input[name="hs-confidence"]').forEach(input => {
        input.checked = filters.confidences.includes(input.value);
    });

    document.querySelectorAll('input[name="hs-source"]').forEach(input => {
        input.checked = filters.sources.includes(input.value);
    });

    toggleNasaSection();
    toggleCustomDates();
}

function toggleCustomDates() {
    const isCustom = document.getElementById('hs-period').value === 'custom';

    document
        .getElementById('hs-custom-dates')
        .classList.toggle('hs-show', isCustom);
}

// Tampilkan/sembunyikan bagian filter satelit NASA jika sumber NASA dinonaktifkan
function toggleNasaSection() {
    const nasaChecked = document.querySelector('input[name="hs-source"][value="nasa"]')?.checked;
    const section = document.getElementById('hs-nasa-section');

    if (section) {
        section.style.display = nasaChecked ? '' : 'none';
    }
}

document.getElementById('hs-period').addEventListener('change', toggleCustomDates);

document.querySelectorAll('input[name="hs-source"]').forEach(input => {
    input.addEventListener('change', toggleNasaSection);
});

document.getElementById('hs-toggle').addEventListener('click', () => {
    const body = document.getElementById('hs-body');
    const icon = document.getElementById('hs-toggle-icon');

    const collapsed = body.classList.toggle('hs-collapsed');
    icon.textContent = collapsed ? '▸' : '▾';
});

document.getElementById('hs-apply').addEventListener('click', () => {
    const next = readFiltersFromForm();

    if (next.period === 'custom') {
        if (!next.start || !next.end) {
            setStatus('Isi tanggal awal dan akhir.', true);
            return;
        }

        if (next.start > next.end) {
            setStatus('Tanggal awal tidak boleh setelah tanggal akhir.', true);
            return;
        }
    }

    if (next.sources.length === 0) {
        setStatus('Pilih minimal satu sumber data.', true);
        return;
    }

    if (next.sources.includes('nasa') && (next.satellites.length === 0 || next.confidences.length === 0)) {
        setStatus('Pilih minimal satu satelit dan satu confidence NASA.', true);
        return;
    }

    filters = next;
    loadHotspots();
});

document.getElementById('hs-reset').addEventListener('click', () => {
    filters = JSON.parse(JSON.stringify(DEFAULT_FILTERS));
    writeFiltersToForm();
    loadHotspots();
});

// Muat data awal (24 jam terakhir)
writeFiltersToForm();
loadHotspots();

// ===============================
// DATA DUMMY POS DAMKAR
// ===============================

L.marker([-2.1310, 106.1100], { icon: fireStationIcon })
    .bindPopup(`
        <b>🚒 Pos Damkar Pangkalpinang</b><br>
        Status: Aktif
    `)
    .addTo(fireStationLayer);

L.marker([-2.0670, 105.1900], { icon: fireStationIcon })
    .bindPopup(`
        <b>🚒 Pos Damkar Muntok</b><br>
        Status: Aktif
    `)
    .addTo(fireStationLayer);

// ===============================
// TAMPILKAN LAYER DEFAULT
// ===============================

fireIncidentLayer.addTo(map);
nasaHotspotLayer.addTo(map);
himawariHotspotLayer.addTo(map);
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
    '🔴 Hotspot NASA FIRMS': nasaHotspotLayer,
    '🟣 Hotspot Himawari': himawariHotspotLayer,
    '🚒 Pos Damkar': fireStationLayer,
    '🗺️ Batas Wilayah Babel': boundaryLayer
};

L.control.layers(baseMaps, overlayLayers).addTo(map);