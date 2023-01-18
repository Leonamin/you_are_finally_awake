import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/di/location_service.dart';
import 'package:you_are_finally_awake/di/service_locator.dart';

class DestinationSettingPage extends StatefulWidget {
  const DestinationSettingPage({super.key});

  @override
  State<DestinationSettingPage> createState() => _DestinationSettingPageState();
}

class _DestinationSettingPageState extends State<DestinationSettingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getLocation() {
    locator<LocationService>().getLocation().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.amber,
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
