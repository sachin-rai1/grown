import 'package:get/get.dart';

import '../controllers/ups_reading_controller.dart';

class UpsReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpsReadingController>(
      () => UpsReadingController(),
    );
  }
}
