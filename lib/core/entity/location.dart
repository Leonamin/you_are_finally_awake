import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double latitude;
  final double longitude;
  final double altitude;

  const Location(
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
