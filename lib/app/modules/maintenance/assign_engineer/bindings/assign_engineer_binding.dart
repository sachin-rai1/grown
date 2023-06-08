import 'package:get/get.dart';

import '../controllers/assign_engineer_controller.dart';

class AssignEngineerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignEngineerController>(
      () => AssignEngineerController(),
    );
  }
}
