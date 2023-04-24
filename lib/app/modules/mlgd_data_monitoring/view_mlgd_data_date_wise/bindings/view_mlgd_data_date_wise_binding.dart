import 'package:get/get.dart';

import '../controllers/view_mlgd_data_date_wise_controller.dart';

class ViewMlgdDataDateWiseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewMlgdDataDateWiseController>(
      () => ViewMlgdDataDateWiseController(),
    );
  }
}
