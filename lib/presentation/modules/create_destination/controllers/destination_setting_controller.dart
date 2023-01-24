import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';

class DestinationSettingController extends GetxController {
  final DestinationInfoRepository _repository = Get.find(
    tag: (DestinationInfoRepositoryImpl).toString(),
  );

  // 초기위치 서울 시청
  Rx<LocationEntity> _currentLocation =
      LocationEntity(latitude: 37.5666805, longitude: 126.9784147, altitude: 0)
          .obs;
  LocationEntity get currentLocation => _currentLocation.value;
  LatLng get currentLatLng =>
      LatLng(_currentLocation.value.latitude, _currentLocation.value.longitude);

  @override
  void onInit() {
    once(
      _currentLocation,
      (callback) {},
    );
    super.onInit();
  }

  LocationEntity getLocation() {
    return LocationEntity(latitude: 0, longitude: 0, altitude: 0);
  }
}
