import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/models/destination_info_ui_data.dart';
import 'package:you_are_finally_awake/presentation/modules/home/widgets/destination_info_card.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';

class DestinationInfoList extends StatelessWidget {
  final List<DestinationInfoUiData> dataModel;
  const DestinationInfoList({
    super.key,
    required this.dataModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.padding),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: dataModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppValues.halfPadding),
            child: DestinationInfoCard(
              title: dataModel[index].title,
              location: dataModel[index].location,
            ),
          );
        },
      ),
    );
  }
}
