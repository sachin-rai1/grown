import 'package:get/get.dart';

import '../controllers/bcdi_classification_controller.dart';

class BcdiClassificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BcdiClassificationController>(
      () => BcdiClassificationController(),
    );
  }
}
