import 'package:get/get.dart';
import 'package:you_are_finally_awake/core/domain/repository/destination_info_repository.dart';
import 'package:you_are_finally_awake/core/data/repository/destination_info_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DestinationInfoRepository>(
      () => DestinationInfoRepositoryImpl(),
      tag: (DestinationInfoRepositoryImpl).toString(),
      fenix: true,
    );
  }
}
