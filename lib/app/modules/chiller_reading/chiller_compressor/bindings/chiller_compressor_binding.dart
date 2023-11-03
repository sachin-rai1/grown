import 'package:get/get.dart';

import '../controllers/chiller_compressor_controller.dart';

class ChillerCompressorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChillerCompressorController>(
      () => ChillerCompressorController(),
    );
  }
}
