import 'package:get/get.dart';

import '../controllers/insert_pcc_reading_controller.dart';

class InsertPccReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InsertPccReadingController>(
      () => InsertPccReadingController(),
    );
  }
}
