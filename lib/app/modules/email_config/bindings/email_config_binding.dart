import 'package:get/get.dart';

import '../controllers/email_config_controller.dart';

class EmailConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmailConfigController>(
      () => EmailConfigController(),
    );
  }
}
