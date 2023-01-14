import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/destination_info.dart';

class DestinationInfoProvider extends ChangeNotifier {
  late Box<DestinationInfo> destinationInfoBox;
  final List<DestinationInfo> destinationInfoList = [];

  void call() async {
    debugPrint("Initialize box");
    try {
      destinationInfoBox =
          await Hive.openBox<DestinationInfo>('destination_info');
      final List<dynamic> infoList = destinationInfoBox.values.toList();
      destinationInfoList.addAll(infoList as List<DestinationInfo>);
    } catch (e) {}

    notifyListeners();
  }

  int _findValidInfoId(int infoId) {
    int originIndex =
        destinationInfoList.indexWhere((info) => info.id == infoId);
    debugPrint("$infoId를 가진 정보의 리스트 내 인덱스 = $originIndex");
    if (originIndex == -1) {
      debugPrint("origin info not found");
      throw Exception();
    }
    return originIndex;
  }

  void addInfo(CreateDestinationInfo createInfo) async {
    final int nextId =
        destinationInfoList.isNotEmpty ? destinationInfoList.last.id + 1 : 1;
    final newInfo = DestinationInfo(
      id: nextId,
      title: createInfo.title,
      location: createInfo.location,
      radius: createInfo.radius,
      periodicMinute: createInfo.periodicMinute,
    );

    try {
      await destinationInfoBox.put(newInfo.id, newInfo);
    } catch (e) {
      debugPrint("Hive put failed");
      debugPrint(e.toString());
      return;
    }
    destinationInfoList.add(newInfo);
    notifyListeners();
  }

  void updateInfo(int infoId, CreateDestinationInfo createInfo) async {
    late int validInfoIndex;
    try {
      validInfoIndex = _findValidInfoId(infoId);
    } catch (e) {
      debugPrint("this info id is not exist on list");
      return;
    }

    final updatedInfo = DestinationInfo(
      id: validInfoIndex,
      title: createInfo.title,
      location: createInfo.location,
      radius: createInfo.radius,
      periodicMinute: createInfo.periodicMinute,
    );

    try {
      await destinationInfoBox.put(infoId, updatedInfo);
    } catch (e) {
      debugPrint("Hive put failed");
      debugPrint(e.toString());
      return;
    }
    destinationInfoList[validInfoIndex] = updatedInfo;
    notifyListeners();
  }

  void deleteInfo(int infoId) async {
    late int validInfoIndex;
    try {
      validInfoIndex = _findValidInfoId(infoId);
    } catch (e) {
      debugPrint("this info id is not exist on list");
      return;
    }

    try {
      await destinationInfoBox.delete(infoId);
      // 삭제 완료되면 ui도 갱신
      destinationInfoList.removeAt(validInfoIndex);
      notifyListeners();
    } catch (e) {
      debugPrint("Hive delete failed");
      debugPrint(e.toString());
      return;
    }
  }
}
