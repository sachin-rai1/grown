import 'package:get/get.dart';

import '../controllers/register_complain_controller.dart';

class RegisterComplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterComplainController>(
      () => RegisterComplainController(),
    );
  }
}
