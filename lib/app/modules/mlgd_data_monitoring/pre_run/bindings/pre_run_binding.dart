import 'package:get/get.dart';

import '../controllers/pre_run_controller.dart';

class PreRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreRunController>(
      () => PreRunController(),
    );
  }
}
