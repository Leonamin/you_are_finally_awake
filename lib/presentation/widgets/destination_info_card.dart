import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';

class DestinationInfoCard extends StatelessWidget {
  final String? title;
  final LocationEntity? location;
  final double? radius;
  final int? periodicMinute;

  const DestinationInfoCard({
    super.key,
    this.title,
    this.location,
    this.radius,
    this.periodicMinute,
  });

  final double defaultRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 정보
            Column(
              children: [
                Text(
                  title ?? "Destination",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Lat: ${location?.latitude ?? 0},   Lon: ${location?.longitude ?? 0}",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            // 버튼
            OutlinedButton(
              onPressed: () {},
              child: Text(
                "Start!",
              ),
            )
          ],
        ),
      ),
    );
  }
}
