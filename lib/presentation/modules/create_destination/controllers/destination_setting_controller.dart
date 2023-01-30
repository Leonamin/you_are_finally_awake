import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/domain/entity/create_destination_info_entity.dart';
import 'package:you_are_finally_awake/core/values/constants.dart';
import 'package:you_are_finally_awake/presentation/router/app_routes.dart';
import 'package:you_are_finally_awake/presentation/services/location_service.dart';

class DestinationSettingController extends GetxController {
  static const String destinationMarkerId = 'destination';
  static const String destinationCircleId = 'destination';
  static const String currentMarkerId = 'current';

  final DestinationInfoRepository _repository = Get.find(
    tag: (DestinationInfoRepositoryImpl).toString(),
  );

  final LocationService _locationService = Get.find(
    tag: (LocationService).toString(),
  );

  // M 단위
  RxDouble _destinationRadius = Constants.defaultDestinationRadius.obs;
  double get destinationRadius => _destinationRadius.value;

  // 초기위치 서울 시청 37.5666805,126.9784147
  Rxn<LocationData?> get currentLocation => _locationService.currentLocation;
  LatLng currentLatLng = const LatLng(37.5666805, 126.9784147);

  // 목적지 정보가 null이면 목적지 설정이 안된걸로 취급
  // 초기, 목적지 취소 = null
  Rxn<LocationInfoEntity?> _destination = Rxn<LocationInfoEntity>();
  LocationInfoEntity? get destination => _destination.value;

  // 구글맵 구성
  Completer<GoogleMapController> googleMapController = Completer();

  RxList<Marker> _markers = RxList.empty();
  List<Marker> get markers => _markers;

  RxList<Circle> _circles = RxList.empty();
  List<Circle> get circles => _circles;

  // 상태 관리
  TextEditingController titleController = TextEditingController();

  @override
  void onInit() {
    _locationService.doPeriodicSensing(true);
    _setCurrentLocation();
    _setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);
    animateToMap(currentLatLng);

    // 계속 카메라를 움직이면 방해가 된다.
    once(
      currentLocation,
      (callback) {
        // TODO 목적지와 현재 위치를 비교해서 두 사이의 거리를 표시한다.
        debugPrint("현재 위치 변경");
        if (_setCurrentLocation()) {
          _setCurrentMarker(currentLatLng.latitude, currentLatLng.longitude);
          animateToMap(currentLatLng);
        }
      },
    );
    ever(
      _destination,
      (callback) {
        debugPrint("목적지 변경");
        if (destination != null) {
          _setDestinationMarker(destination!.latitude, destination!.longitude);
          _setDestinationRangeCircle(
              destination!.latitude, destination!.longitude);
        }
      },
    );
    ever(_destinationRadius, (callback) {
      _setDestinationRangeCircle(destination!.latitude, destination!.longitude);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _locationService.doPeriodicSensing(false);
    super.onClose();
  }

  // 데이터 설정

  bool _setCurrentLocation() {
    if (currentLocation.value != null &&
        currentLocation.value?.latitude != null &&
        currentLocation.value?.longitude != null) {
      currentLatLng = LatLng(
          currentLocation.value!.latitude!, currentLocation.value!.longitude!);
      return true;
    }
    return false;
  }

  void setDestination(double latitude, double longitude) {
    _destination(LocationInfoEntity(latitude: latitude, longitude: longitude));

    // 테스트
    // print(_destination.value
    //     ?.distanceBetween(currentLatLng.latitude, currentLatLng.longitude));
    // if (_destination.value != null) {
    //   if (_destination.value!.distanceBetween(
    //           currentLatLng.latitude, currentLatLng.longitude) <
    //       100) {
    //     print('하핳');
    //   }
    // }
  }

  void changeRadius(double value) {
    _destinationRadius(value);
  }

  String formatDestinationRadius() {
    if (destinationRadius < 1000.0) {
      return "${destinationRadius.round()}m";
    }
    return "${(destinationRadius / 1000).toStringAsFixed(3)}km";
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
    final CreateDestinationInfoEntity newItem = CreateDestinationInfoEntity(
      // TODO 목적지 정보 생성 제목
      title: titleController.text,
      location: LocationInfoEntity(
        latitude: destination!.latitude,
        longitude: destination!.longitude,
      ),
      radius: destinationRadius,
      // TODO 목적지 정보 생성 위치 확인 주기
      periodicSecond: 60,
    );
    _repository.createDestinationInfo(newItem);

    // FIXME 그냥 뒤로가기 해버리면 로딩이 안되는데 이것도 좋은 방법은 아님
    // 안드로이드 Flow나 LiveData처럼 데이터베이스 변경사항 발생시 홈 뷰모델로 변경사항이 전달되야함
    Get.offAllNamed(AppRoutes.HOME);
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
      draggable: true,
      onDragStart: (value) {
        _deleteDestinationRangeCircle();
      },
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
