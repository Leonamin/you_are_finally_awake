import 'dart:math';

import 'package:equatable/equatable.dart';

class LocationInfoEntity extends Equatable {
  final double latitude;
  final double longitude;

  const LocationInfoEntity({required this.latitude, required this.longitude});

  // return type: meters
  double distanceBetween(double lat, double lon) {
    double lat1 = _radiansFromDegrees(latitude);
    double lon1 = _radiansFromDegrees(longitude);

    double lat2 = _radiansFromDegrees(lat);
    double lon2 = _radiansFromDegrees(lon);

    const double earthRadius = 6378137.0; // WGS84 major axis
    double distance = 2 *
        earthRadius *
        asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) +
            cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));

    return distance;
  }

  // m단위
  // https://stackoverflow.com/questions/60503089/how-to-calculate-distance-between-two-location-on-flutterresult-should-be-mete/69437789#69437789
  /*
  double calculateDistance(double lat, double lon) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latitude - lat) * p) / 2 +
        c(latitude * p) * c(lat * p) * (1 - c((longitude - lon) * p)) / 2;
    // 결과가 km이므로 1000을 곱해 m로 바꿔주자
    // 12742는 지구 지름
    return 1000 * 12742 * asin(sqrt(a));
  }
  */

  double _radiansFromDegrees(final double degrees) => degrees * (pi / 180.0);

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
