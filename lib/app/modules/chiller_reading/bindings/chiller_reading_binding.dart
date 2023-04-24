import 'package:get/get.dart';

import '../controllers/chiller_reading_controller.dart';

class ChillerReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChillerReadingController>(
      () => ChillerReadingController(),
    );
  }
}
