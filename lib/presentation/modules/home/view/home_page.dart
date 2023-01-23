import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/entity/create_destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/modules/home/controllers/home_controller.dart';
import 'package:you_are_finally_awake/presentation/modules/home/widgets/home_main_panel.dart';
import 'package:you_are_finally_awake/presentation/modules/home/widgets/destination_info_list.dart';

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
                  controller.addInfo(
                    CreateDestinationInfo(
                        title: "xptmxm",
                        location: LocationEntity(
                            latitude: 1, longitude: 1, altitude: 1),
                        radius: 1,
                        periodicMinute: 1),
                  );
                },
              ),
              DestinationInfoList(
                dataModel: controller.destinationInfoList,
                onItemLongPressed: (index) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("삭제하기"),
                        content: Container(
                          child: Text("정말로 삭제하시겠습니까?"),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                controller.deleteInfo(
                                    controller.destinationInfoList[index].id);
                                Get.back();
                              },
                              child: Text("삭제")),
                          TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text("취소")),
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
