import 'package:get_it/get_it.dart';
import 'package:you_are_finally_awake/di/location_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LocationService());
}
