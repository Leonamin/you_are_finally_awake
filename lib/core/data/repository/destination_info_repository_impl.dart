import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/data/datasource/hive/destination_info_hive_datasource.dart';
import 'package:you_are_finally_awake/core/data/mapper/create_destination_info_dto_mapper.dart';
import 'package:you_are_finally_awake/core/data/mapper/destination_dto_mapper.dart';
import 'package:you_are_finally_awake/core/domain/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/domain/entity/destination_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/entity/create_destination_info_entity.dart';

class DestinationInfoRepositoryImpl extends DestinationInfoRepository {
  final DestinationInfoHiveDataSource _hiveDataSource = Get.find(
    tag: (DestinationInfoHiveDataSource).toString(),
  );
  final destinationInfoDTOMapper = DestinationDTOMapper();
  final createDestinationInfoDTOMapper = CreateDestinationInfoDTOMapper();

  @override
  Future<int> createDestinationInfo(CreateDestinationInfoEntity newItem) {
    return _hiveDataSource
        .createInfo(createDestinationInfoDTOMapper.map(newItem));
  }

  @override
  Future<void> deleteDestinationInfoById(int id) {
    return _hiveDataSource.deleteInfo(id);
  }

  @override
  Future<List<DestinationInfoEntity>> getAllDestinationInfo() async {
    return [
      ..._hiveDataSource
          .getInfoList()
          .map((e) => destinationInfoDTOMapper.map(e))
    ];
  }

  @override
  Future<DestinationInfoEntity> getDestinationInfoById(int id) async {
    return destinationInfoDTOMapper.map(await _hiveDataSource.getInfo(id));
  }

  @override
  Future<int> updateDestinationInfoById(
      int id, CreateDestinationInfoEntity newItem) async {
    return _hiveDataSource.updateInfo(
        id, createDestinationInfoDTOMapper.map(newItem));
  }
}
