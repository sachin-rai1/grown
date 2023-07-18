import 'package:get/get.dart';

import '../controllers/pcc_data_controller.dart';

class PccDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PccDataController>(
      () => PccDataController(),
    );
  }
}
