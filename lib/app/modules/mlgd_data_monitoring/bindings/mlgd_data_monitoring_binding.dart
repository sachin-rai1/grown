import 'package:get/get.dart';

import '../controllers/mlgd_data_monitoring_controller.dart';

class MlgdDataMonitoringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MlgdDataMonitoringController>(
      () => MlgdDataMonitoringController(),
    );
  }
}
