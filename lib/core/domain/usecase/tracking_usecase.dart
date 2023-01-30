import 'dart:async';

import 'package:you_are_finally_awake/core/domain/entity/destination_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/repository/destination_info_repository.dart';

class TrackingUsecase {
  late DestinationInfoRepository destinationInfoRepository;
  late DestinationInfoEntity destinationInfo;
  LocationInfoEntity? currentLocation;
  Future<LocationInfoEntity?> Function()? updateLocation;
  Function()? notifyUpdateLocation;
  Function()? notifyHasArrived;
  late Timer _timer;
  // 위치 요청 상태
  bool isRequesting = false;

  TrackingUsecase({
    required this.destinationInfoRepository,
    this.updateLocation,
    this.notifyUpdateLocation,
    this.notifyHasArrived,
  });

  Future<void> call(int id) async {
    destinationInfo =
        await destinationInfoRepository.getDestinationInfoById(id);
    _trackingTimer();
  }

  // 업데이트 되면 true
  Future<bool> updateCurrentLocation() async {
    if (updateLocation == null) {
      return false;
    }
    final LocationInfoEntity? location = await updateLocation!();
    if (location != null) {
      currentLocation = location;
      if (notifyUpdateLocation != null) notifyUpdateLocation!();
      return true;
    }
    return false;
  }

  Future<void> checkLocation() async {
    if (isRequesting) {
      return;
    }
    isRequesting = true;
    await updateCurrentLocation();
    // 현재 위치가 잡히지 않으면 그대로 멈춤
    if (currentLocation == null) {
      return;
    }
    if (destinationInfo.isInArea(
        currentLocation!.latitude, currentLocation!.longitude)) {
      _timer.cancel();
      if (notifyHasArrived != null) {
        notifyHasArrived!();
      }
    }
    isRequesting = false;
  }

  _trackingTimer() {
    final duration = Duration(seconds: destinationInfo.periodicSecond);
    _timer = Timer.periodic(duration, (Timer timer) async {
      // 요청 중이면 재요청 보내지 않음
      // async 슬립이 아닌이상 주기적으로 실행되므로 이미 요청을 보낸 주기(A)에서 다음주기(B) 호출 때까지 반환이 없으면 다음주기(B)는 빠져나온다.
      checkLocation();
    });
  }

  cancelTracking() {
    _timer.cancel();
  }
}
