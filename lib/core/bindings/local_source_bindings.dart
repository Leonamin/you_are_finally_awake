import 'package:get/instance_manager.dart';
import 'package:you_are_finally_awake/core/data/datasource/hive/destination_info_hive_datasource.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationInfoHiveDataSource>(
      () => DestinationInfoHiveDataSource(),
      tag: (DestinationInfoHiveDataSource).toString(),
      fenix: true,
    );
  }
}
