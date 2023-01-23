import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/modules/home/controllers/home_controller.dart';
import 'package:you_are_finally_awake/presentation/router/routes.dart';
import 'package:you_are_finally_awake/presentation/widgets/destination_info_card.dart';
import 'package:you_are_finally_awake/presentation/widgets/destination_info_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              flex: 8,
              child: ListView.builder(
                itemCount: controller.destinationInfoList.length,
                itemBuilder: (context, index) => InkWell(
                  onLongPress: () {
                    controller
                        .deleteInfo(controller.destinationInfoList[index].id);
                  },
                  child: DestinationInfoCard(
                    title: controller.destinationInfoList[index].title,
                    location: controller.destinationInfoList[index].location,
                  ),
                  // child: Container(
                  //   child: Text(
                  //       provider.destinationInfoList[index].id.toString()),
                  // ),
                ),
              ),
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      controller.addInfo(
                        CreateDestinationInfo(
                            title: "테스트",
                            location: LocationEntity(
                              latitude: 37,
                              longitude: 127,
                              altitude: 0,
                            ),
                            radius: 100,
                            periodicMinute: 1),
                      );
                    },
                    child: Text("추가"))),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.goNamed(destinationSettingPageName);
        },
      ),
    );
  }
}
