import 'package:get/get.dart';

import '../controllers/process_pump_controller.dart';

class ProcessPumpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcessPumpController>(
      () => ProcessPumpController(),
    );
  }
}
