import 'package:get/get.dart';

import '../controllers/search_by_serial_no_controller.dart';

class SearchBySerialNoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchBySerialNoController>(
      () => SearchBySerialNoController(),
    );
  }
}
