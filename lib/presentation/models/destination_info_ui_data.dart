import 'package:equatable/equatable.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';

class DestinationInfoUiData extends Equatable {
  final int id;
  final String title;
  final LocationEntity location;
  final double radius;
  final int periodicMinute;

  const DestinationInfoUiData({
    required this.id,
    required this.title,
    required this.location,
    required this.radius,
    required this.periodicMinute,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        location,
        radius,
        periodicMinute,
      ];
}
