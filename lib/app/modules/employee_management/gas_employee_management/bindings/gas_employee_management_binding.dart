import 'package:get/get.dart';

import '../controllers/gas_employee_management_controller.dart';

class GasEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasEmployeeManagementController>(
      () => GasEmployeeManagementController(),
    );
  }
}
