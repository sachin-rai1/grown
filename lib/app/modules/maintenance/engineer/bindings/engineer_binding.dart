import 'package:get/get.dart';

import '../controllers/engineer_controller.dart';

class EngineerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EngineerController>(
      () => EngineerController(),
    );
  }
}
