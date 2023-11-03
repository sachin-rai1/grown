import 'package:get/get.dart';

import '../controllers/date_wise_complain_controller.dart';

class DateWiseComplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateWiseComplainController>(
      () => DateWiseComplainController(),
    );
  }
}
