import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:you_are_finally_awake/core/values/constants.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/controllers/destination_setting_controller.dart';
import 'package:you_are_finally_awake/presentation/values/app_values.dart';
import 'package:you_are_finally_awake/presentation/widgets/resizable_bottom_sheet.dart';

class DestinationSettingPage extends GetView<DestinationSettingController> {
  const DestinationSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () => GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLatLng,
                      zoom: 11,
                    ),
                    onTap: (argument) {
                      controller.setDestination(
                          argument.latitude, argument.longitude);
                    },
                    markers: Set.from(controller.markers),
                    onMapCreated: (gmapController) {
                      // FIXME 화면 껏다 키면 메모리 할당 해제되서 controller를 잃어버리는거 같음...
                      controller.googleMapController.complete(gmapController);
                    },
                  ),
                ),
                SafeArea(
                  child: Stack(
                    children: [
                      // TODO 검색바
                      Padding(
                        padding: const EdgeInsets.all(AppValues.padding),
                        child: Container(
                          height: 50,
                          color: Colors.white60,
                        ),
                      ),

                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(AppValues.radius),
                            topRight: Radius.circular(AppValues.radius),
                          ),
                          child: ResizableBottomSheet(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.75,
                            child: AspectRatio(
                              aspectRatio: 4 / 3,
                              // 설정 탭
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(AppValues.padding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 이름 설정
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextFormField(
                                            controller:
                                                controller.titleController,
                                            decoration: const InputDecoration(
                                              hintText: '목적지 이름',
                                            ),
                                            maxLength: Constants
                                                .maxDestinationInfoTitleLength,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      // 범위 설정
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "목적지 도착 범위",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          SliderTheme(
                                            data: SliderThemeData(
                                                overlayShape:
                                                    SliderComponentShape
                                                        .noOverlay),
                                            child: Obx(
                                              () => Slider(
                                                value: controller
                                                    .destinationRadius,
                                                label: controller
                                                    .destinationRadius
                                                    .round()
                                                    .toString(),
                                                max: Constants
                                                    .maxDestinationRadius,
                                                min: Constants
                                                    .minDestinationRadius,
                                                onChanged: (value) {
                                                  controller
                                                      .changeRadius(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Obx(
                                              () => Text(controller
                                                  .formatDestinationRadius()),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("취소"),
                )),
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    controller.createData();
                  },
                  child: Text("저장"),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
