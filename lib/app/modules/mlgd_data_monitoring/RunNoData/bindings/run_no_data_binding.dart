import 'package:get/get.dart';

import '../controllers/run_no_data_controller.dart';

class RunNoDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RunNoDataController>(
      () => RunNoDataController(),
    );
  }
}
