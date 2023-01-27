import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/bindings/local_source_bindings.dart';
import 'package:you_are_finally_awake/core/bindings/repository_bindings.dart';
import 'package:you_are_finally_awake/presentation/services/location_service.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    LocalSourceBindings().dependencies();
    RepositoryBindings().dependencies();
    Get.put<LocationService>(
      LocationService(),
      tag: (LocationService).toString(),
    );
  }
}
