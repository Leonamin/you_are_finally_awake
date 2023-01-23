import 'package:flutter/material.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';

class HomeMainCard extends StatelessWidget {
  final Function()? onAddPressed;
  final Function()? onFavoritePressed;
  final Function()? onLastPressed;
  const HomeMainCard({
    super.key,
    this.onAddPressed,
    this.onFavoritePressed,
    this.onLastPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppValues.padding),
      child: AspectRatio(
        aspectRatio: 1.8 / 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.radius),
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.all(AppValues.halfPadding),
            child: Row(
              children: [
                // 위치 추가
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppValues.radius),
                    child: InkWell(
                      onTap: onAddPressed,
                      child: Container(
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: AppValues.smallPadding,
                ),
                // 마지막 위치, 즐겨 찾기
                Expanded(
                  child: Column(
                    children: [
                      // 즐겨찾기
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.radius),
                          child: Container(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppValues.smallPadding,
                      ),
                      // 마지막 위치
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppValues.radius),
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
