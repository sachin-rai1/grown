import 'package:get/get.dart';

import '../controllers/growing_controller.dart';

class GrowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GrowingController>(
      () => GrowingController(),
    );
  }
}
