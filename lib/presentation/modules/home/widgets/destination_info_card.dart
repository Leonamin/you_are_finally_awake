import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(AppValues.radius_12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppValues.halfPadding),
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
              child: const Text(
                "Start!",
              ),
            )
          ],
        ),
      ),
    );
  }
}
