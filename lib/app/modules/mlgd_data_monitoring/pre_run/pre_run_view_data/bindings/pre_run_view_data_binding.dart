import 'package:get/get.dart';

import '../controllers/pre_run_view_data_controller.dart';

class PreRunViewDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreRunViewDataController>(
      () => PreRunViewDataController(),
    );
  }
}
