import 'package:get/get.dart';

import '../controllers/datewise_chiller_reading_controller.dart';

class DatewiseChillerReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatewiseChillerReadingController>(
      () => DatewiseChillerReadingController(),
    );
  }
}
