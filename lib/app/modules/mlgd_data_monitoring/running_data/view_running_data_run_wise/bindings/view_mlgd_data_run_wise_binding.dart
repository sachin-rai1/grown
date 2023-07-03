import 'package:get/get.dart';

import '../controllers/view_mlgd_data_run_wise_controller.dart';

class ViewMlgdDataRunWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewMlgdDataRunWiseController>(
      () => ViewMlgdDataRunWiseController(),
    );
  }
}
