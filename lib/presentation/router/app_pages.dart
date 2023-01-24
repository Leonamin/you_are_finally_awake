import 'package:get/get.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/controllers/destination_setting_controller.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/view/destination_setting_page.dart';
// import 'package:you_are_finally_awake/presentation/modules/create_destination/destination_setting_page.dart';
import 'package:you_are_finally_awake/presentation/modules/home/view/home_page.dart';

import 'app_routes.dart';

appPages() => [
      GetPage(
        name: AppRoutes.HOME,
        page: () => const HomePage(),
      ),
      GetPage(
        name: AppRoutes.DESTINATION_SETTING,
        page: () => const DestinationSettingPage(),
        binding: BindingsBuilder(
          () {
            Get.put(DestinationSettingController());
          },
        ),
      ),
    ];
