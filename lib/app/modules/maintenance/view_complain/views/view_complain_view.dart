import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';
import 'package:grown/app/modules/maintenance/view_complain/date_wise_complain/views/date_wise_complain_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:photo_view/photo_view.dart';

import '../branch_wise_complain/views/branch_wise_complain_view.dart';
import '../controllers/view_complain_controller.dart';

class ViewComplainView extends GetView<ViewComplainController> {
  ViewComplainView({Key? key}) : super(key: key);

  final viewComplainController = Get.put(ViewComplainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ReportTabBar(
          title: const Text("Complain"),
          tabs: const [
            Text("DateWise"),
            Text("BranchWise"),
          ],
          children: [
            DateWiseComplainView(),
            BranchWiseComplainView()
          ],
        ));
  }
}
