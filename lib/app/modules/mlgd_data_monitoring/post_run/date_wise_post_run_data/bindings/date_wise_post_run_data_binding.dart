import 'package:get/get.dart';

import '../controllers/date_wise_post_run_data_controller.dart';

class DateWisePostRunDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DateWisePostRunDataController>(
      () => DateWisePostRunDataController(),
    );
  }
}
