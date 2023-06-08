import 'package:get/get.dart';

import '../controllers/view_complain_controller.dart';

class ViewComplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewComplainController>(
      () => ViewComplainController(),
    );
  }
}
