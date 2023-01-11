import 'package:equatable/equatable.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';

class DestinationInfo extends Equatable {
  // 정보 순서 없으면 안됨
  final int id;
  // 알람의 제목 없으면 ""
  final String title;
  // 목적지 위치 없을리가 없겠지
  final Location location;
  // 목적지 반경(meter) 없으면 기본 500m? 탑승물에 따라서 바꿔야할거 같음
  final double radius;
  // 위치 확인 간격 (필요한지 모르겠음)
  final int periodicMinute;

  const DestinationInfo({
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
