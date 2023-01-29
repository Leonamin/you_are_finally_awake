import 'package:you_are_finally_awake/core/data/mapper/mapper.dart';
import 'package:you_are_finally_awake/core/domain/entity/destination_info_entity.dart';
import 'package:you_are_finally_awake/presentation/models/destination_info_ui_data.dart';

class DestinationInfoUiDataMapper
    extends Mapper<DestinationInfoEntity, DestinationInfoUiData> {
  @override
  DestinationInfoUiData map(object) {
    return DestinationInfoUiData(
      id: object.id,
      title: object.title,
      location: object.locationInfo,
      radius: object.radius,
      periodicMinute: object.periodicMinute,
    );
  }
}
