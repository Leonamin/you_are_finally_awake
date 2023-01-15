import 'package:hive_flutter/hive_flutter.dart';
import 'package:you_are_finally_awake/core/data/datasource/constants.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/destination_info.dart';

class DestinationInfoHiveDataSource {
  final Box<DestinationInfo> destinationInfoBox =
      Hive.box<DestinationInfo>(hiveBoxDestinationInfo);

  // 기본 구조
  // DestinationInfo의 id와 Box의 key는 1:1로 매칭된다.

  List<DestinationInfo> getInfoList() {
    try {
      return destinationInfoBox.values.toList();
    } catch (e) {
      rethrow;
    }
  }

  // 마지막 아이템의 아이디를 가져온다.
  // 마지막 아이템이 없으면 0
  int _getLastItemId() {
    List<DestinationInfo> values = destinationInfoBox.values.toList();
    if (values.isEmpty) {
      return 0;
    }
    return values.last.id;
  }

  // 지정한 key의 아이템이 없으면 Not Found 예외를 호출한다.
  Future<DestinationInfo> getInfo(int key) async {
    try {
      DestinationInfo? info = destinationInfoBox.get(key);
      if (info == null) {
        //TODO Exceptiopn Info Not Found
        throw Exception();
      }
      return info;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> createInfo(CreateDestinationInfo createInfo) async {
    try {
      int incresedId = _getLastItemId() + 1;
      DestinationInfo newInfo = DestinationInfo(
        id: incresedId,
        title: createInfo.title,
        location: createInfo.location,
        radius: createInfo.radius,
        periodicMinute: createInfo.periodicMinute,
      );
      await destinationInfoBox.put(newInfo.id, newInfo);
      return newInfo.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> updateInfo(int key, CreateDestinationInfo createInfo) async {
    try {
      DestinationInfo updateInfo = DestinationInfo(
        id: key,
        title: createInfo.title,
        location: createInfo.location,
        radius: createInfo.radius,
        periodicMinute: createInfo.periodicMinute,
      );
      await destinationInfoBox.put(updateInfo.id, updateInfo);
      return updateInfo.id;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteInfo(int key) async {
    try {
      await destinationInfoBox.delete(key);
    } catch (e) {
      rethrow;
    }
  }
}
