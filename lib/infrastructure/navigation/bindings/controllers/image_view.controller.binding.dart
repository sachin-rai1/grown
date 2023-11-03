import 'package:get/get.dart';

import '../../../../presentation/imageView/controllers/image_view.controller.dart';

class ImageViewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageViewController>(
      () => ImageViewController(),
    );
  }
}
