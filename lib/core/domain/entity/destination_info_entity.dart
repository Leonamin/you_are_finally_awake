import 'package:equatable/equatable.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';

class DestinationInfoEntity extends Equatable {
  final int id;
  final String title;
  final LocationInfoEntity locationInfo;
  final double radius; // meters
  final int periodicSecond;

  const DestinationInfoEntity({
    required this.id,
    required this.title,
    required this.locationInfo,
    required this.radius,
    required this.periodicSecond,
  });

  bool isInArea(double lat, double lon) {
    if (locationInfo.distanceBetween(lat, lon) < radius) {
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        locationInfo,
        radius,
        periodicSecond,
      ];
}
