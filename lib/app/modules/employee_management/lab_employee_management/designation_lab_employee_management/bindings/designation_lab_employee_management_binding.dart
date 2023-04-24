import 'package:get/get.dart';

import '../controllers/designation_lab_employee_management_controller.dart';

class DesignationLabEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DesignationLabEmployeeManagementController>(
      () => DesignationLabEmployeeManagementController(),
    );
  }
}
