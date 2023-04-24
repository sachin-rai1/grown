import 'package:get/get.dart';

import '../controllers/camera_application_controller.dart';

class CameraApplicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraApplicationController>(
      () => CameraApplicationController(),
    );
  }
}
