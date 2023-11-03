import 'package:get/get.dart';

import '../controllers/branch_wise_complain_controller.dart';

class BranchWiseComplainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BranchWiseComplainController>(
      () => BranchWiseComplainController(),
    );
  }
}
