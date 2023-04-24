import 'package:get/get.dart';

import '../controllers/special_skill_lab_employee_management_controller.dart';

class SpecialSkillLabEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialSkillLabEmployeeManagementController>(
      () => SpecialSkillLabEmployeeManagementController(),
    );
  }
}
