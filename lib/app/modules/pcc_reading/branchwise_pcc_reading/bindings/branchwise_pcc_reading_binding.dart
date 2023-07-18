import 'package:get/get.dart';

import '../controllers/branchwise_pcc_reading_controller.dart';

class BranchwisePccReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchwisePccReadingController>(
      () => BranchwisePccReadingController(),
    );
  }
}
