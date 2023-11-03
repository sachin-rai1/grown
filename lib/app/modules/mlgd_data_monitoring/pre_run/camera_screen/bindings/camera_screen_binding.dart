import 'package:get/get.dart';
import '../controllers/camera_screen_controller.dart';

class CameraScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraScreenController>(
      () => CameraScreenController(),
    );
  }
}
