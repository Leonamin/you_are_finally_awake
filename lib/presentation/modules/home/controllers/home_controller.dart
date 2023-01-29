import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/domain/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';
import 'package:you_are_finally_awake/core/domain/entity/create_destination_info_entity.dart';
import 'package:you_are_finally_awake/presentation/mapper/destination_info_ui_data_mapper.dart';
import 'package:you_are_finally_awake/presentation/models/destination_info_ui_data.dart';

class HomeController extends GetxController {
  final DestinationInfoRepository _repository = Get.find(
    tag: (DestinationInfoRepositoryImpl).toString(),
  );
  final RxList<DestinationInfoUiData> _destinationInfoListController =
      RxList.empty();
  final mapper = DestinationInfoUiDataMapper();

  List<DestinationInfoUiData> get destinationInfoList =>
      _destinationInfoListController.toList();

  Future<List<DestinationInfoUiData>> getAllInfo() async {
    final response = await _repository.getAllDestinationInfo();
    return List<DestinationInfoUiData>.from(response.map((e) => mapper.map(e)));
  }

  @override
  void onInit() async {
    super.onInit();
    debugPrint("초기화!");
    try {
      // destinationInfoList.addAll(await getAllInfo());
      _destinationInfoListController.addAll(await getAllInfo());
    } catch (e) {
      debugPrint('Failed to fetch list');
    }
  }

  void addInfo(CreateDestinationInfoEntity createInfo) async {
    try {
      int key = await _repository.createDestinationInfo(createInfo);
      debugPrint('추가된 키 $key');
      _destinationInfoListController
          .add(mapper.map(await _repository.getDestinationInfoById(key)));
    } catch (e) {
      debugPrint("Hive creating data failed");
      debugPrint(e.toString());
      return;
    }
  }

  void updateInfo(int infoId, CreateDestinationInfoEntity createInfo) async {
    try {
      int key = await _repository.updateDestinationInfoById(infoId, createInfo);
      debugPrint('업데이트된 키 $key');
      final updateDataIndex = _destinationInfoListController
          .indexWhere((info) => info.id == infoId);
      _destinationInfoListController[updateDataIndex] =
          mapper.map(await _repository.getDestinationInfoById(key));
    } catch (e) {
      debugPrint("Hive updating data failed");
      debugPrint(e.toString());
      return;
    }
  }

  void deleteInfo(int infoId) async {
    try {
      debugPrint('삭제된 키 $infoId');
      await _repository.deleteDestinationInfoById(infoId);
      _destinationInfoListController.removeWhere((info) => info.id == infoId);
    } catch (e) {
      debugPrint("Hive deleting data failed");
      debugPrint(e.toString());
      return;
    }
  }
}
