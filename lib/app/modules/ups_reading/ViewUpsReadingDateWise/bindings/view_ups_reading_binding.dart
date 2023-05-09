import 'package:get/get.dart';

import '../controllers/view_ups_reading_controller.dart';

class ViewUpsReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewUpsReadingDateWiseController>(
      () => ViewUpsReadingDateWiseController(),
    );
  }
}
