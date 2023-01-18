import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/di/location_service.dart';
import 'package:you_are_finally_awake/di/service_locator.dart';

class DestinationSettingPage extends StatefulWidget {
  const DestinationSettingPage({super.key});

  @override
  State<DestinationSettingPage> createState() => _DestinationSettingPageState();
}

class _DestinationSettingPageState extends State<DestinationSettingPage> {
  Completer<GoogleMapController> _googleMapController = Completer();

  final double _defaultBorderRadius = 24;

  LatLng currentLatLng = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void getLocation() {
    locator<LocationService>().getLocation().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(_defaultBorderRadius),
              child: SizedBox(
                height: 300,
                // SingleChildScrollView에 넣으면 화면 이동을 제대로 할 수 없다
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: currentLatLng,
                    zoom: 11.0,
                  ),
                  onMapCreated: (controller) {
                    _googleMapController.complete(controller);
                    locator<LocationService>().getLocation().then(
                      (value) {
                        print("초기 값! = $value");

                        if (value != null &&
                            value.latitude != null &&
                            value.longitude != null) {
                          print("설정!");
                          currentLatLng =
                              LatLng(value.latitude!, value.longitude!);
                          _googleMapController.future.then(
                            (GoogleMapController controller) {
                              // controller.moveCamera(
                              //   CameraUpdate.newCameraPosition(
                              //     CameraPosition(
                              //         target: currentLatLng, zoom: 11.0),
                              //   ),
                              // );
                              controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: currentLatLng, zoom: 11.0),
                                ),
                              );
                            },
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Flexible(
              child: ListView(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(_defaultBorderRadius),
                    child: Column(
                      children: [
                        Container(
                          height: 300,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 300,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getLocation();
        },
      ),
    );
  }
}
