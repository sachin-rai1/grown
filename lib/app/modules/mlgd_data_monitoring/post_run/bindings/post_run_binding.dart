import 'package:get/get.dart';

import '../controllers/post_run_controller.dart';

class PostRunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRunController>(
      () => PostRunController(),
    );
  }
}
