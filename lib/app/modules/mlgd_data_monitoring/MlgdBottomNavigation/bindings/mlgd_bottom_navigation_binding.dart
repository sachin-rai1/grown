import 'package:get/get.dart';

import '../controllers/mlgd_bottom_navigation_controller.dart';

class MlgdBottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MlgdBottomNavigationController>(
      () => MlgdBottomNavigationController(),
    );
  }
}
