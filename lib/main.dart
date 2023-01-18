import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:you_are_finally_awake/core/data/datasource/constants.dart';
import 'package:you_are_finally_awake/core/entity/destination_info.dart';
import 'package:you_are_finally_awake/core/entity/location.dart';
import 'package:you_are_finally_awake/presentation/router/main_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocationAdapter());
  Hive.registerAdapter(DestinationInfoAdapter());
  await Hive.openBox<DestinationInfo>(hiveBoxDestinationInfo);

  runApp(const MyApp());
}

const Color seedColor = Color.fromARGB(255, 22, 212, 108);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
