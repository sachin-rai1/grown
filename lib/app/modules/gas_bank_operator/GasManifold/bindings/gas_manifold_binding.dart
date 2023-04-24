import 'package:get/get.dart';

import '../controllers/gas_manifold_controller.dart';

class GasManifoldBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasManifoldController>(
      () => GasManifoldController(),
    );
  }
}
