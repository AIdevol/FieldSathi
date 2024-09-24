import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapViewScreenController extends GetxController {
  final mapController = MapController();
  final center = LatLng(51.509364, -0.128928).obs;
  final zoom = 9.2.obs;

  void updateCenter(LatLng newCenter) {
    center.value = newCenter;
    mapController.move(newCenter, mapController.camera.zoom);
  }

  void updateZoom(double newZoom) {
    zoom.value = newZoom;
    mapController.move(mapController.camera.center, newZoom);
  }

  void onMapTap(TapPosition tapPosition, LatLng point) {
    // Handle map tap event
    print('Tapped at: $point');
    // You can add more logic here, like adding a marker at the tapped location
  }
}