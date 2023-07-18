import 'package:get/get.dart';

import '../controllers/pcc_reading_controller.dart';

class PccReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PccReadingController>(
      () => PccReadingController(),
    );
  }
}
