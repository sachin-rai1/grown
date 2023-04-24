import 'package:get/get.dart';

import '../controllers/gas_vendor_controller.dart';

class GasVendorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GasVendorController>(
      () => GasVendorController(),
    );
  }
}
