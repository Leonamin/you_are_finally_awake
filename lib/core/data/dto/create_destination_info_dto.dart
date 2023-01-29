import 'package:you_are_finally_awake/core/data/dto/location_info_hive_dto.dart';

class CreateDestinationInfoDTO {
  final String title;
  final LocationInfoHiveDTO location;
  final double radius;
  final int periodicMinute;

  const CreateDestinationInfoDTO({
    required this.title,
    required this.location,
    required this.radius,
    required this.periodicMinute,
  });
}
