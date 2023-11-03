import 'package:get/get.dart';

import '../controllers/gallery_screen_controller.dart';

class GalleryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryScreenController>(
      () => GalleryScreenController(),
    );
  }
}
