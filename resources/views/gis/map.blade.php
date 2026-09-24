<!DOCTYPE html>
<html lang="id">

<head>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Si Jago Merah - GIS</title>

    <link
        rel="stylesheet"
        href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
    >

    {{-- GIS CSS --}}
    @vite(['resources/css/gis/map.css'])

</head>

<body>

    <div id="map"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    @vite(['resources/js/gis/map.js'])

</body>

</html>