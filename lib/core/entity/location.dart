import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'location.g.dart';

@HiveType(typeId: 1)
class LocationEntity extends Equatable {
  @HiveField(1)
  final double latitude;
  @HiveField(2)
  final double longitude;
  @HiveField(3)
  final double altitude;

  const LocationEntity(
      {required this.latitude,
      required this.longitude,
      required this.altitude});

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        altitude,
      ];
}
