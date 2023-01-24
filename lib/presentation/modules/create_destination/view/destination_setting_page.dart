import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/controllers/destination_setting_controller.dart';

class DestinationSettingPage extends GetView<DestinationSettingController> {
  const DestinationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: controller.currentLatLng,
              zoom: 11,
            ),
          ),
        ],
      ),
    );
  }
}
