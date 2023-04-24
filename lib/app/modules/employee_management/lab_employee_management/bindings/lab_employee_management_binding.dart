import 'package:get/get.dart';

import '../controllers/lab_employee_management_controller.dart';

class LabEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LabEmployeeManagementController>(
      () => LabEmployeeManagementController(),
    );
  }
}
