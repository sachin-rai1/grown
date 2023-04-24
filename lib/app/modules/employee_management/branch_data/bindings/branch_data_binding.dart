import 'package:get/get.dart';

import '../controllers/branch_data_controller.dart';

class BranchDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchDataController>(
      () => BranchDataController(),
    );
  }
}
