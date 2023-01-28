import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/router/app_routes.dart';

class DestinationSettingController extends GetxController {
  static const String destinationMarkerId = 'destination';
  static const String currentMarkerId = 'current';

  final DestinationInfoRepository _repository = Get.find(
    tag: (DestinationInfoRepositoryImpl).toString(),
  );

  // KM 단위
  RxDouble _destinationRadius = 100.0.obs;
  double get destinationRadius => _destinationRadius.value;

  // 초기위치 서울 시청
  Rx<LocationEntity> _currentLocation =
      LocationEntity(latitude: 37.5666805, longitude: 126.9784147, altitude: 0)
          .obs;
  LocationEntity get currentLocation => _currentLocation.value;
  LatLng get currentLatLng =>
      LatLng(_currentLocation.value.latitude, _currentLocation.value.longitude);

  // 목적지 정보가 null이면 목적지 설정이 안된걸로 취급
  // 초기, 목적지 취소 = null
  Rxn<LocationEntity?> _destination = Rxn<LocationEntity>();
  LocationEntity? get destination => _destination.value;

  // 구글맵 구성
  RxList<Marker> _markers = RxList.empty();
  List<Marker> get markers => _markers;

  @override
  void onInit() {
    _setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);

    ever(
      _currentLocation,
      (callback) {
        // TODO 목적지와 현재 위치를 비교해서 두 사이의 거리를 표시한다.
        debugPrint("현재 위치 변경");
        _setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);
      },
    );
    ever(
      _destination,
      (callback) {
        debugPrint("목적지 변경");
        if (destination != null) {
          _setDestinationMarker(destination!.latitude, destination!.longitude);
        }
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
    _destinationRadius(value);
  }

  bool validateSettings() {
    if (destination == null) {
      return false;
    }

    return true;
  }

  void createData() {
    if (!validateSettings()) {
      Get.snackbar(
        '생성 실패!',
        '목적지가 설정되지 않았습니다.',
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      );
      return;
    }
    final CreateDestinationInfo newItem = CreateDestinationInfo(
      // TODO 목적지 정보 생성 제목
      title: '',
      location: LocationEntity(
          latitude: destination!.latitude,
          longitude: destination!.longitude,
          altitude: 0),
      radius: destinationRadius,
      // TODO 목적지 정보 생성 위치 확인 주기
      periodicMinute: 1,
    );
    _repository.createDestinationInfo(newItem);

    // FIXME 그냥 뒤로가기 해버리면 로딩이 안되는데 이것도 좋은 방법은 아님
    // 안드로이드 Flow나 LiveData처럼 데이터베이스 변경사항 발생시 홈 뷰모델로 변경사항이 전달되야함
    Get.offAllNamed(AppRoutes.HOME);
  }

  // 구글맵 마커 관련
  void _setCurrentMarker(double latitude, double longitude) {
    _markers
        .removeWhere((element) => element.markerId.value == currentMarkerId);
    final Marker marker = Marker(
      markerId: const MarkerId(currentMarkerId),
      draggable: false,
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: "현재 위치"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    _markers.add(marker);
  }

  void _setDestinationMarker(double latitude, double longitude) {
    _markers.removeWhere(
        (element) => element.markerId.value == destinationMarkerId);
    final Marker marker = Marker(
      markerId: const MarkerId(destinationMarkerId),
      draggable: true,
      onDragEnd: (value) {
        setDestination(value.latitude, value.longitude);
      },
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: "목적지"),
    );
    _markers.add(marker);
  }

  void _deleteDestinationMarker() {
    _markers.removeWhere(
        (element) => element.markerId.value == destinationMarkerId);
  }
}
