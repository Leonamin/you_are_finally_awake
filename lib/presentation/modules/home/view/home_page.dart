import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/view/destination_setting_page.dart';
import 'package:you_are_finally_awake/presentation/modules/home/controllers/home_controller.dart';
import 'package:you_are_finally_awake/presentation/modules/home/widgets/home_main_panel.dart';
import 'package:you_are_finally_awake/presentation/modules/home/widgets/destination_info_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:you_are_finally_awake/presentation/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              HomeMainCard(
                onAddPressed: () {
                  // 테스트
                  // controller.addInfo(
                  //   CreateDestinationInfo(
                  //       title: "xptmxm",
                  //       location: LocationEntity(
                  //           latitude: 1, longitude: 1, altitude: 1),
                  //       radius: 1,
                  //       periodicMinute: 1),
                  // );
                  Get.toNamed(AppRoutes.DESTINATION_SETTING);
                },
              ),
              DestinationInfoList(
                dataModel: controller.destinationInfoList,
                onItemLongPressed: (index) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            AppLocalizations.of(context)!.deleteDialogTitle),
                        content: Text(
                            AppLocalizations.of(context)!.deleteExplanation),
                        actions: [
                          TextButton(
                              onPressed: () {
                                controller.deleteInfo(
                                    controller.destinationInfoList[index].id);
                                Get.back();
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.delete)),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(AppLocalizations.of(context)!.back)),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
