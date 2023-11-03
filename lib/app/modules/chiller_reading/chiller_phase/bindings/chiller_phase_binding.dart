import 'package:get/get.dart';

import '../controllers/chiller_phase_controller.dart';

class ChillerPhaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChillerPhaseController>(
      () => ChillerPhaseController(),
    );
  }
}
