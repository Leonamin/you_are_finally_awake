import 'package:flutter/cupertino.dart';
import 'package:you_are_finally_awake/core/data/datasource/hive/destination_info_hive_datasource.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/destination_info.dart';

class DestinationInfoProvider extends ChangeNotifier {
  final List<DestinationInfo> destinationInfoList = [];
  DestinationInfoHiveDataSource destinationInfoHiveDataSource =
      DestinationInfoHiveDataSource();

  void call() async {
    debugPrint("Initialize box");
    try {
      destinationInfoList.addAll(destinationInfoHiveDataSource.getInfoList());
    } catch (e) {
      debugPrint("Fetch list failed");
    }

    notifyListeners();
  }

  void addInfo(CreateDestinationInfo createInfo) async {
    try {
      int key = await destinationInfoHiveDataSource.createInfo(createInfo);
      debugPrint('추가된 키 $key');
      destinationInfoList.add(await destinationInfoHiveDataSource.getInfo(key));
      notifyListeners();
    } catch (e) {
      debugPrint("Hive creating data failed");
      debugPrint(e.toString());
      return;
    }
  }

  void updateInfo(int infoId, CreateDestinationInfo createInfo) async {
    try {
      int key =
          await destinationInfoHiveDataSource.updateInfo(infoId, createInfo);
      debugPrint('업데이트된 키 $key');
      final updateDataIndex =
          destinationInfoList.indexWhere((info) => info.id == infoId);

      destinationInfoList.removeAt(updateDataIndex);
      destinationInfoList.insert(
          updateDataIndex, await destinationInfoHiveDataSource.getInfo(key));
      notifyListeners();
    } catch (e) {
      debugPrint("Hive updating data failed");
      debugPrint(e.toString());
      return;
    }
  }

  void deleteInfo(int infoId) async {
    try {
      debugPrint('삭제된 키 $infoId');
      await destinationInfoHiveDataSource.deleteInfo(infoId);
      destinationInfoList.removeWhere((info) => info.id == infoId);
      notifyListeners();
    } catch (e) {
      debugPrint("Hive deleting data failed");
      debugPrint(e.toString());
      return;
    }
  }
}
