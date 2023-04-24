import 'package:get/get.dart';

import '../controllers/gases_controller.dart';

class GasesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasesController>(
      () => GasesController(),
    );
  }
}
