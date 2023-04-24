import 'package:get/get.dart';

import '../controllers/gas_bank_operator_controller.dart';

class GasBankOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasBankOperatorController>(
      () => GasBankOperatorController(),
    );
  }
}
