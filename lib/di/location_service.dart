import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  bool _serviceEnabled = false;
  PermissionStatus _permissionGranted = PermissionStatus.denied;

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

    return await location.getLocation();
  }
}
