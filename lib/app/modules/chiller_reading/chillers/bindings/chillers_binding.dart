import 'package:get/get.dart';

import '../controllers/chillers_controller.dart';

class ChillersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChillersController>(
      () => ChillersController(),
    );
  }
}
