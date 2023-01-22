import 'package:get/get.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/destination_setting_page.dart';
import 'package:you_are_finally_awake/presentation/modules/home/view/home_page.dart';

import 'app_routes.dart';

final appPages = [
  GetPage(
    name: AppRoutes.HOME,
    page: () => const HomePage(),
  ),
  GetPage(
    name: AppRoutes.DESTINATION_SETTING,
    page: () => DestinationSettingPage(),
  ),
];
