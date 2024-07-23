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

  //products
  List<LatLng> get _productPoints => const [
        LatLng(55.755793, 37.617134),
        LatLng(55.095960, 38.765519),
        LatLng(56.129038, 40.406502),
        LatLng(54.513645, 36.261268),
      ];

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
    final _searchOnMapProductController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(55.755793, 37.617134),
              initialZoom: 5,
              minZoom: 0,
              maxZoom: 19,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'lensfront',
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
              MarkerLayer(
                markers: _getProductMarkers(_productPoints),
              )
            ],
          ),
          Positioned(
            top: 50,
            left: 50,
            child: Container(
                width: MediaQuery.of(context).size.width - 90,
                height: 41,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: MaterialButton(
                  onPressed: () {},
                  child: TextField(
                    controller: _searchOnMapProductController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Поиск",
                        prefixIcon: const Icon(Icons.search),
                        prefixStyle: GoogleFonts.inter(color: Colors.grey)),
                  ),
                )),
          ),
          Positioned(
            bottom: 20,
            right: 5,
            child: ElevatedButton(
              onPressed: () {
                updateLocation();
                initState();
              },
              child: Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }

  List<Marker> _getProductMarkers(List<LatLng> _productPoints) {
    return List.generate(
      _productPoints.length,
      (index) => Marker(
        point: _productPoints[index],
        child: const Icon(
          Icons.place,
          color: Colors.red,
        ),
        width: 50,
        height: 50,
        alignment: Alignment.center,
      ),
    );
  }
}
