import 'package:you_are_finally_awake/core/data/dto/location_info_hive_dto.dart';
import 'package:you_are_finally_awake/core/data/mapper/mapper.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';

class LocationHiveDTOMapper
    extends Mapper<LocationInfoHiveDTO, LocationInfoEntity> {
  @override
  LocationInfoEntity map(LocationInfoHiveDTO object) {
    return LocationInfoEntity(
      latitude: object.latitude,
      longitude: object.longitude,
    );
  }

  LocationInfoHiveDTO reverseMap(LocationInfoEntity object) {
    return LocationInfoHiveDTO(
      latitude: object.latitude,
      longitude: object.longitude,
      altitude: 0,
    );
  }
}
