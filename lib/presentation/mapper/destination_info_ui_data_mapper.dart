import 'package:you_are_finally_awake/core/entity/destination_info.dart';
import 'package:you_are_finally_awake/presentation/mapper/mapper.dart';
import 'package:you_are_finally_awake/presentation/models/destination_info_ui_data.dart';

class DestinationInfoUiDataMapper
    extends Mapper<DestinationInfo, DestinationInfoUiData> {
  @override
  DestinationInfoUiData map(object) {
    return DestinationInfoUiData(
      id: object.id,
      title: object.title,
      location: object.location,
      radius: object.radius,
      periodicMinute: object.periodicMinute,
    );
  }
}
