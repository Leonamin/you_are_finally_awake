
import 'package:equatable/equatable.dart';

class LocationInfoEntity extends Equatable {
  final double latitude;
  final double longitude;

  const LocationInfoEntity({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
