import 'package:get/get.dart';

import '../controllers/edit_assigned_engineer_controller.dart';

class EditAssignedEngineerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAssignedEngineerController>(
      () => EditAssignedEngineerController(),
    );
  }
}
