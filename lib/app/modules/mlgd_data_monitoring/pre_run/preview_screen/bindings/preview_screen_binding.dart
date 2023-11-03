import 'package:get/get.dart';

import '../controllers/preview_screen_controller.dart';

class PreviewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewScreenController>(
      () => PreviewScreenController(),
    );
  }
}
