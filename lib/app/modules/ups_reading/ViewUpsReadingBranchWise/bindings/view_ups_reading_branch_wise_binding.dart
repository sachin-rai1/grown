import 'package:get/get.dart';

import '../controllers/view_ups_reading_branch_wise_controller.dart';

class ViewUpsReadingBranchWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewUpsReadingBranchWiseController>(
      () => ViewUpsReadingBranchWiseController(),
    );
  }
}
