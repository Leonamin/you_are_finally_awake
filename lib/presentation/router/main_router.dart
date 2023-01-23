import 'package:go_router/go_router.dart';
import 'package:you_are_finally_awake/presentation/modules/create_destination/destination_setting_page.dart';
import 'package:you_are_finally_awake/presentation/modules/home/view/home_page.dart';
import 'package:you_are_finally_awake/presentation/router/routes.dart';

final mainRouter = GoRouter(
  routes: [
    GoRoute(
      name: homePageName,
      path: homePagePath,
      builder: (context, state) => HomePage(),
      routes: [
        GoRoute(
          name: destinationSettingPageName,
          path: destinationSettingPagePath,
          builder: (context, state) => DestinationSettingPage(),
        ),
      ],
    ),
  ],
);
