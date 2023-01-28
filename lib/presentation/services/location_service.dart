import 'dart:async';

import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService extends GetxService {
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;
  bool _doPeriodicSensing = false;
  Rxn<LocationData?> currentLocation = Rxn<LocationData>();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    // requestService();
    // grantPermission();
    getLocation();
  }

  @override
  void onReady() {
    _startTimer();
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  Future<bool> requestService() async {
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }

    return _serviceEnabled;
  }

  Future<bool> grantPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  Future<LocationData?> getLocation() async {
    if (!_serviceEnabled) {
      if (!await requestService()) {
        return null;
      }
    }
    if (_permissionGranted == PermissionStatus.denied) {
      if (!await grantPermission()) {
        return null;
      }
    }
    final LocationData locationData = await location.getLocation();
    currentLocation(locationData);
    return locationData;
  }

  void doPeriodicSensing(bool trigger) {
    _doPeriodicSensing = trigger;
  }

  // TODO 포그라운드일 때만 되니까 백그라운드로 스위칭 할 때 꺼야함
  _startTimer() {
    const duration = Duration(seconds: 5);
    _timer = Timer.periodic(duration, (Timer timer) {
      if (_doPeriodicSensing) {
        print("위치 갱신!");
        location
            .getLocation()
            .timeout(const Duration(seconds: 4))
            .then((value) {
          currentLocation(value);
        });
      }
    });
  }
}
