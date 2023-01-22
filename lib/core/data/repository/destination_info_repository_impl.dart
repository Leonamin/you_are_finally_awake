import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/data/datasource/hive/destination_info_hive_datasource.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/entity/destination_info.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';

class DestinationInfoRepositoryImpl extends DestinationInfoRepository {
  final DestinationInfoHiveDataSource _hiveDataSource = Get.find(
    tag: (DestinationInfoHiveDataSource).toString(),
  );

  @override
  Future<int> createDestinationInfo(CreateDestinationInfo newItem) {
    return _hiveDataSource.createInfo(newItem);
  }

  @override
  Future<void> deleteDestinationInfoById(int id) {
    return _hiveDataSource.deleteInfo(id);
  }

  @override
  Future<List<DestinationInfo>> getAllDestinationInfo() async {
    return _hiveDataSource.getInfoList();
  }

  @override
  Future<DestinationInfo> getDestinationInfoById(int id) {
    return _hiveDataSource.getInfo(id);
  }

  @override
  Future<int> updateDestinationInfoById(int id, CreateDestinationInfo newItem) {
    return _hiveDataSource.updateInfo(id, newItem);
  }
}
