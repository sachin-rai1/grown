import 'package:get/get.dart';

import '../controllers/electrical_employee_management_controller.dart';

class ElectricalEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElectricalEmployeeManagementController>(
      () => ElectricalEmployeeManagementController(),
    );
  }
}
