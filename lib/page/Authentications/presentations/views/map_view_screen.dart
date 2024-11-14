import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/map_Screen_controller.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import '../../../../constans/color_constants.dart';
import '../../../../utilities/helper_widget.dart';

class MapViewScreen extends GetView<MapViewScreenController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<MapViewScreenController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
              backgroundColor: appColor,
              title: Text('Map', style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15)),
            ),
            body: Obx(() => Stack(
              children: [
                FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                    onTap: controller.onMapTap,
                    initialCenter: controller.center.value,
                    initialZoom: controller.zoom.value,
                    onMapEvent: (MapEvent mapEvent) {
                      if (mapEvent is MapEventMove) {
                        controller.updateCenter(mapEvent.camera.center);
                        controller.updateZoom(mapEvent.camera.zoom);
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: controller.center.value,
                          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    color: Colors.white.withOpacity(0.7),
                    child: Text(
                      'Lat: ${controller.center.value.latitude.toStringAsFixed(4)}, '
                          'Lng: ${controller.center.value.longitude.toStringAsFixed(4)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            )),
            floatingActionButton: FloatingActionButton(
              backgroundColor: appColor,
              child: const Icon(Icons.my_location),
              onPressed: controller.getCurrentLocation,
            ),
          ),
        ),
      ),
    );
  }
}