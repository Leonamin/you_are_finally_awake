import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:you_are_finally_awake/core/bindings/initial_binding.dart';
import 'package:you_are_finally_awake/core/data/datasource/constants.dart';
import 'package:you_are_finally_awake/core/data/dto/destination_info_hive_dto.dart';
import 'package:you_are_finally_awake/core/data/dto/location_info_hive_dto.dart';
import 'package:you_are_finally_awake/presentation/router/app_pages.dart';
import 'package:you_are_finally_awake/presentation/router/app_routes.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocationInfoHiveDTOAdapter());
  Hive.registerAdapter(DestinationInfoHiveDTOAdapter());
  await Hive.openBox<DestinationInfoHiveDTO>(hiveBoxDestinationInfo);

  // Notification 설정
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) async {},
  );
  final LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  runApp(const MyApp());
}

const Color seedColor = Color.fromARGB(255, 45, 133, 160);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //FIXME 위치 요청이랑 겹치기 때문에 권한 요청 따로 빼야함
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestPermission();

    // .router를 쓰면
    // Get.to~ 안되고
    // Get.rootDelegate.to~를 써야한다.
    return GetMaterialApp(
      title: 'YAFA',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.HOME,
      getPages: appPages(),
    );
  }
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Stateless는 빌드가 1번만 발생하니까 이렇게 써도 되지 않을까?
    locator<LocationService>().requestService();
    locator<LocationService>().grantPermission();
    
    return MaterialApp.router(
      title: 'Flutter Demo',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
      ),
      // 아래 처럼 하면 null thrown이 발생한다.
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('ko', ""),
      //   Locale('en', ""),
      // ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: mainRouter,
    );
  }
}
*/