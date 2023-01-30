import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/core/domain/entity/location_info_entity.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';

class DestinationInfoCard extends StatelessWidget {
  final String? title;
  final LocationInfoEntity? location;
  final double? radius;
  final int? periodicMinute;
  final Function()? onStartPressed;

  const DestinationInfoCard({
    super.key,
    this.title,
    this.location,
    this.radius,
    this.periodicMinute,
    this.onStartPressed,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? "Destination",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Lat: ${location?.latitude ?? 0}\nLon: ${location?.longitude ?? 0}",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  "Range: ${(radius ?? 0).round()}m",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
            // 버튼
            OutlinedButton(
              onPressed: onStartPressed,
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
