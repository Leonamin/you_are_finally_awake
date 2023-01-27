import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';

class DestinationSettingController extends GetxController {
  static const String destinationMarkerId = 'destination';
  static const String currentMarkerId = 'current';

  final DestinationInfoRepository _repository = Get.find(
    tag: (DestinationInfoRepositoryImpl).toString(),
  );

  RxDouble currentRadius = 100.0.obs;
  // double get currentRadius => _currentRadius.value;

  // 초기위치 서울 시청
  Rx<LocationEntity> _currentLocation =
      LocationEntity(latitude: 37.5666805, longitude: 126.9784147, altitude: 0)
          .obs;
  LocationEntity get currentLocation => _currentLocation.value;
  LatLng get currentLatLng =>
      LatLng(_currentLocation.value.latitude, _currentLocation.value.longitude);

  // 목적지 정보가 null이면 목적지 설정이 안된걸로 취급
  // 초기, 목적지 취소 = null
  Rx<LocationEntity?> _destination = null.obs;
  LocationEntity? get destination => _destination.value;

  // 구글맵 구성
  RxList<Marker> _markers = RxList.empty();
  List<Marker> get markers => _markers;

  @override
  void onInit() {
    setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);

    ever(
      _currentLocation,
      (callback) {
        // TODO 목적지와 현재 위치를 비교해서 두 사이의 거리를 표시한다.
        setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);
      },
    );
    super.onInit();
  }

  LocationEntity getLocation() {
    return LocationEntity(latitude: 0, longitude: 0, altitude: 0);
  }

  // 데이터 설정
  void setDestination(double latitude, double longitude) {
    _destination(
        LocationEntity(latitude: latitude, longitude: longitude, altitude: 0));
  }

  void changeRadius(double value) {
    currentRadius(value);
  }

  // 구글맵 마커 관련
  void setCurrentMarker(double latitude, double longitude) {
    _markers
        .removeWhere((element) => element.markerId.value == currentMarkerId);
    final Marker marker = Marker(
      markerId: const MarkerId(currentMarkerId),
      draggable: false,
      onDragEnd: (value) {
        setCurrentMarker(value.latitude, value.longitude);
      },
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: "현재 위치"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    _markers.add(marker);
  }

  void setDestinationMarker(double latitude, double longitude) {
    _markers.removeWhere(
        (element) => element.markerId.value == destinationMarkerId);
    final Marker marker = Marker(
      markerId: const MarkerId(destinationMarkerId),
      draggable: true,
      onDragEnd: (value) {
        setDestinationMarker(value.latitude, value.longitude);
      },
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: "목적지"),
    );
    _markers.add(marker);
  }

  void deleteDestinationMarker() {}
}
