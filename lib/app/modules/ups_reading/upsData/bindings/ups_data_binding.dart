import 'package:get/get.dart';

import '../controllers/ups_data_controller.dart';

class UpsDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpsDataController>(
      () => UpsDataController(),
    );
  }
}
