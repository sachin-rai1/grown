import 'package:get/get.dart';

import '../controllers/date_wise_pre_run_data_controller.dart';

class DateWisePreRunDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateWisePreRunDataController>(
      () => DateWisePreRunDataController(),
    );
  }
}
