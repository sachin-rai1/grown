import 'package:get/get.dart';

import '../controllers/bcdi_multi_label_controller.dart';

class BcdiMultiLabelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BcdiMultiLabelController>(
      () => BcdiMultiLabelController(),
    );
  }
}
