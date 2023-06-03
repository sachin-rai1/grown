import 'package:get/get.dart';

import '../controllers/branchwise_chiller_reading_controller.dart';

class BranchwiseChillerReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchwiseChillerReadingController>(
      () => BranchwiseChillerReadingController(),
    );
  }
}
