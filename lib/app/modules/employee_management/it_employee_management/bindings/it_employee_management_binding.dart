import 'package:get/get.dart';

import '../controllers/it_employee_management_controller.dart';

class ItEmployeeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItEmployeeManagementController>(
      () => ItEmployeeManagementController(),
    );
  }
}
