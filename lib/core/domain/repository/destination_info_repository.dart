import 'package:you_are_finally_awake/core/domain/entity/create_destination_info_entity.dart';
import 'package:you_are_finally_awake/core/domain/entity/destination_info_entity.dart';

abstract class DestinationInfoRepository {
  /// 저장되어있는 목적지 정보를 전부 가져온다.
  Future<List<DestinationInfoEntity>> getAllDestinationInfo();

  /// 저장되어있는 목적지 정보를 id로 가져온다.
  Future<DestinationInfoEntity> getDestinationInfoById(int id);

  /// id에 해당하는 목적지 정보를 업데이트 하고 업데이트한 목적지 id를 가져온다.
  Future<int> updateDestinationInfoById(
      int id, CreateDestinationInfoEntity newItem);

  /// 새로운 목적지 정보를 만들고 만든 정보의 id를 반환한다.
  Future<int> createDestinationInfo(CreateDestinationInfoEntity newItem);

  /// id에 해당하는 목적지 정보를 삭제한다.
  Future<void> deleteDestinationInfoById(int id);
}
