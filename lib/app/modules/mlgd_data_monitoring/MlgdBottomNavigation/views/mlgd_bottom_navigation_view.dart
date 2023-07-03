import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/widgets.dart';
import '../../RunNoData/views/run_no_data_view.dart';
import '../../running_data/view_running_data_date_wise/views/view_mlgd_data_date_wise_view.dart';
import '../../running_data/view_running_data_run_wise/views/view_mlgd_data_run_wise_view.dart';
import '../../views/mlgd_data_monitoring_view.dart';
import '../controllers/mlgd_bottom_navigation_controller.dart';

class MlgdBottomNavigationView extends GetView<MlgdBottomNavigationController> {
  const MlgdBottomNavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(
          child: Text(
            'MlgdBottomNavigationView is working',
            style: TextStyle(fontSize: 20),
          ),
        ),
          bottomNavigationBar: MyBottomNavigation(
            title1: 'Mlgd Data',
            title2: 'Run No',
            title3: 'DateWise',
            title4: 'RunWise',
            screens: [
              MlgdDataMonitoringView(),
              RunNoDataView(),
              ViewMlgdDataDateWiseView(),
              ViewMlgdDataRunWiseView()
            ],
            image1: "assets/images/mlgd.png",
            iconData2: Icons.view_comfy_alt_outlined,
            iconData3: Icons.view_comfy_alt_outlined,
            iconData4: Icons.view_comfy_alt_outlined,
          )
      ),
    );
  }
}
