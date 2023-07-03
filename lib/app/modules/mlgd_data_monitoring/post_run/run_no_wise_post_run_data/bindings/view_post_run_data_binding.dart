import 'package:get/get.dart';

import '../controllers/view_post_run_data_controller.dart';

class ViewPostRunDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewPostRunDataController>(
      () => ViewPostRunDataController(),
    );
  }
}
