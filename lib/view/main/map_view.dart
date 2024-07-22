import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import "package:geolocator/geolocator.dart";

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController _mapController;
  Geolocator? _geolocator;
  Position? _position;

  void updateLocation() async {
    try {
      Position userPosition = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .timeout(Duration(seconds: 5));
      setState(() {
        _position = userPosition;
      });
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  List<LatLng> get _mapPoints => const [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _geolocator = Geolocator();
    updateLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final markers = _mapPoints
        .map(
          (latlng) => Marker(
            point: latlng,
            child: const Icon(
              Icons.place,
              color: Colors.red,
              size: 60,
            ),
          ),
        )
        .toList();
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(0, 0),
              initialZoom: 1,
              minZoom: 0,
              maxZoom: 19,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flutter_map_example',
              ),
              CurrentLocationLayer(
                style: LocationMarkerStyle(
                  marker: const DefaultLocationMarker(
                    color: Colors.green,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  markerSize: const Size.square(40),
                  accuracyCircleColor: Colors.green.withOpacity(0.1),
                  headingSectorColor: Colors.green.withOpacity(0.8),
                  headingSectorRadius: 120,
                ),
                moveAnimationDuration: Duration.zero,
              ),
              MarkerLayer(markers: markers)
            ],
          ),
          _searchPlace(context, controller),
          Positioned(
            bottom: 20,
            right: 5,
            child: ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _searchPlace(
      BuildContext context, TextEditingController controller) {
    return Positioned(
      top: 50,
      left: 50,
      child: Container(
          width: MediaQuery.of(context).size.width - 90,
          height: 41,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: MaterialButton(
            onPressed: () {},
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Поиск",
                  prefixIcon: const Icon(Icons.search),
                  prefixStyle: GoogleFonts.inter(color: Colors.grey)),
            ),
          )),
    );
  }
}
