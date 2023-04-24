import 'package:get/get.dart';

import '../controllers/bcdi_detection_controller.dart';

class BcdiDetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BcdiDetectionController>(
      () => BcdiDetectionController(),
    );
  }
}
