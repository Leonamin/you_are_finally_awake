import 'package:you_are_finally_awake/core/data/dto/create_destination_info_dto.dart';
import 'package:you_are_finally_awake/core/data/mapper/location_hive_dto_mapper.dart';
import 'package:you_are_finally_awake/core/data/mapper/mapper.dart';
import 'package:you_are_finally_awake/core/domain/entity/create_destination_info_entity.dart';

class CreateDestinationInfoDTOMapper
    extends Mapper<CreateDestinationInfoEntity, CreateDestinationInfoDTO> {
  @override
  CreateDestinationInfoDTO map(CreateDestinationInfoEntity object) {
    final mapper = LocationHiveDTOMapper();
    return CreateDestinationInfoDTO(
        title: object.title,
        location: mapper.reverseMap(object.location),
        radius: object.radius,
        periodicMinute: object.periodicSecond);
  }
}
