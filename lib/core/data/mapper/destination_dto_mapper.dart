import 'package:you_are_finally_awake/core/data/dto/destination_info_hive_dto.dart';
import 'package:you_are_finally_awake/core/data/mapper/location_hive_dto_mapper.dart';
import 'package:you_are_finally_awake/core/data/mapper/mapper.dart';
import 'package:you_are_finally_awake/core/domain/entity/destination_info_entity.dart';

class DestinationDTOMapper
    extends Mapper<DestinationInfoHiveDTO, DestinationInfoEntity> {
  @override
  DestinationInfoEntity map(DestinationInfoHiveDTO object) {
    final mapper = LocationHiveDTOMapper();
    return DestinationInfoEntity(
        id: object.id,
        title: object.title,
        locationInfo: mapper.map(object.location),
        radius: object.radius,
        periodicSecond: object.periodicMinute);
  }
}
