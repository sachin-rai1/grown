import 'package:get/get.dart';

import '../controllers/datewise_pcc_reading_controller.dart';

class DatewisePccReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatewisePccReadingController>(
      () => DatewisePccReadingController(),
    );
  }
}
