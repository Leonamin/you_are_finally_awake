import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/usecase/tracking_usecase.dart';
import 'package:you_are_finally_awake/presentation/services/location_service.dart';

class TrackingController extends GetxController {
  static const String destinationMarkerId = 'destination';
  static const String destinationCircleId = 'destination';
  static const String currentMarkerId = 'current';

  final LocationService _locationService = Get.find(
    tag: (LocationService).toString(),
  );
  final TrackingUsecase _trackingUsecase = TrackingUsecase(
    destinationInfoRepository: Get.find(
      tag: (DestinationInfoRepositoryImpl).toString(),
    ),
  );
  Rxn<LocationInfoEntity?> _currentLocation = Rxn<LocationInfoEntity>();
  LocationInfoEntity? get currentLocation => _currentLocation.value;
  double get destinationRadius => _trackingUsecase.destinationInfo.radius;
  LatLng get currentLatLng => currentLocation != null
      ? LatLng(currentLocation!.latitude, currentLocation!.longitude)
      : const LatLng(37.5666805, 126.9784147);

  // 구글맵 구성
  Completer<GoogleMapController> googleMapController = Completer();

  RxList<Marker> _markers = RxList.empty();
  List<Marker> get markers => _markers;

  RxList<Circle> _circles = RxList.empty();
  List<Circle> get circles => _circles;

  @override
  void onInit() async {
    super.onInit();

    // 비즈니스 로직 입/출력 설정
    _trackingUsecase.notifyUpdateLocation = () {
      print('위치 업데이트');
      _currentLocation(_trackingUsecase.currentLocation);
    };
    _trackingUsecase.notifyHasArrived = () {
      print("도착 완료!");
      Get.snackbar("도착", "도착함!", backgroundColor: Colors.green);
      // TODO Complete Screen
    };
    _trackingUsecase.updateLocation = () async {
      LocationData? locationData = await _locationService.getLocation();
      if (locationData == null ||
          locationData.latitude == null ||
          locationData.longitude == null) {
        return null;
      }
      return LocationInfoEntity(
          latitude: locationData.latitude!, longitude: locationData.longitude!);
    };

    // 비즈니스 로직 실행
    await _trackingUsecase.call(Get.arguments);

    // 뷰모델 설정
    // 구글 맵 설정
    // 초기 설정
    _setCurrentMarker(
        currentLocation?.latitude ?? 0.0, currentLocation?.longitude ?? 0.0);
    _setDestinationMarker(
      _trackingUsecase.destinationInfo.locationInfo.latitude,
      _trackingUsecase.destinationInfo.locationInfo.longitude,
    );
    _setDestinationRangeCircle(
      _trackingUsecase.destinationInfo.locationInfo.latitude,
      _trackingUsecase.destinationInfo.locationInfo.longitude,
    );
    // 현재위치 갱신 설정
    // 한번만 초기 위치 잡히면 위치 갱신
    once(_currentLocation, (callback) {
      animateToMap(currentLatLng, 11);
    });
    ever(_currentLocation, (callback) {
      _setCurrentMarker(currentLocation!.latitude, currentLocation!.longitude);
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // GETX는 트래킹 컨트롤러가 onDelete 되었다고 하지만 TrackingUsecase는 계속 남아서 타이머가 지속된다.
    _trackingUsecase.cancelTracking();
  }

  // 구글맵 지도 이동 관련
  void animateToMap(LatLng currentLatLng, [double zoom = 11]) {
    googleMapController.future.then((gmapController) =>
        gmapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: currentLatLng, zoom: zoom))));
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
      draggable: false,
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: "목적지"),
    );
    _markers.add(marker);
  }

  void _deleteDestinationMarker() {
    _markers.removeWhere(
        (element) => element.markerId.value == destinationMarkerId);
  }

  void _setDestinationRangeCircle(double latitude, double longitude) {
    _circles.removeWhere(
        (element) => element.circleId.value == destinationCircleId);
    final Circle circle = Circle(
      circleId: const CircleId(destinationCircleId),
      radius: destinationRadius,
      center: LatLng(latitude, longitude),
      strokeColor: Colors.transparent,
      fillColor: Colors.green.withOpacity(0.3),
      strokeWidth: 0,
    );
    _circles.add(circle);
  }

  void _deleteDestinationRangeCircle() {
    _circles.removeWhere(
        (element) => element.circleId.value == destinationCircleId);
  }
}
