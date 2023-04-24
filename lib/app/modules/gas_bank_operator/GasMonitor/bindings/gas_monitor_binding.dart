import 'package:get/get.dart';

import '../controllers/gas_monitor_controller.dart';

class GasMonitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasMonitorController>(
      () => GasMonitorController(),
    );
  }
}
