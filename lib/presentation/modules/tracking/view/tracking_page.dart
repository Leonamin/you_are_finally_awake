import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/presentation/modules/tracking/controllers/tracking_controller.dart';

class TrackingPage extends GetView<TrackingController> {
  const TrackingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: controller.currentLatLng, zoom: 11),
              markers: Set.from(controller.markers),
              circles: Set.from(controller.circles),
              onMapCreated: (gmapController) {
                // FIXME 화면 껏다 키면 메모리 할당 해제되서 controller를 잃어버리는거 같음...
                controller.googleMapController.complete(gmapController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
