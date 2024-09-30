import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/constans/const_local_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/services/APIs/auth_services/auth_api_services.dart';

class MapViewScreenController extends GetxController {
  final mapController = MapController();
  final center = LatLng(51.509364, -0.128928).obs;
  final zoom = 9.2.obs;
  Timer? locationTimer;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    startLocationUpdates();
  }

  @override
  void onClose() {
    locationTimer?.cancel();
    super.onClose();
  }

  void updateCenter(LatLng newCenter) {
    center.value = newCenter;
    mapController.move(newCenter, mapController.camera.zoom);
  }

  void updateZoom(double newZoom) {
    zoom.value = newZoom;
    mapController.move(mapController.camera.center, newZoom);
  }

  void onMapTap(TapPosition tapPosition, LatLng point) {
    print('Tapped at: $point');
    // You can add more logic here, like adding a marker at the tapped location
  }

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          toast('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        toast('Location permissions are permanently denied');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      updateCenter(LatLng(position.latitude, position.longitude));
      updateZoom(15.0);
      if (position.latitude != 0 && position.longitude != 0){
        storage.write(longitudeRealTime, position.longitude);
        storage.write(latitudeRealTime, position.latitude);
      }else{
        toast('location not found');
      }
      print('Current location: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      toast('Error getting location: $e');
    }
  }

  void startLocationUpdates() {
    locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      getCurrentLocation();
      hitmapApiCall();
    });
  }

  void hitmapApiCall() async {
    final id = storage.read(userId);
    final longitude = storage.read(longitudeRealTime);
    final latitude = storage.read(latitudeRealTime);
    bool gpsStatus = await Geolocator.isLocationServiceEnabled();
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    var mapData = {
      "gps_status": gpsStatus,
      "longitude": longitude,
      "latitude": latitude
    };
    Get.find<AuthenticationApiService>().updateUserDetailsApiCall(id: id, dataBody: mapData).then((value) {
      var mapdetails = value;
      print("live location=$mapdetails");
      customLoader.hide();
      toast("Location update successfully ");
      update();
    }).onError((error, stackError) {
      customLoader.hide();
      toast(error.toString());
    });
  }
}