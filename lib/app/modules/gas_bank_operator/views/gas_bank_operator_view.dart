import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../GasManifold/views/gas_manifold_view.dart';
import '../GasMonitor/views/gas_monitor_view.dart';
import '../GasVendor/views/gas_vendor_view.dart';
import '../Gases/views/gases_view.dart';
import '../controllers/gas_bank_operator_controller.dart';

class GasBankOperatorView extends GetView<GasBankOperatorController> {
  GasBankOperatorView({Key? key}) : super(key: key);
  final gasBankOperatorController = Get.put(GasBankOperatorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome To Gas Bank'),
          centerTitle: true,
        ),
        bottomNavigationBar: MyBottomNavigation(
          title1: 'Gas Monitor',
          title2: "Gases",
          title3: 'Gas Manifold',
          title4: 'Gas Vendor',
          screens: [
            GasMonitorView(),
            GasesView(),
            GasManifoldView(),
            GasVendorView(),
          ],
          iconData1: Icons.monitor,
          iconData2: Icons.gas_meter,
          iconData3: Icons.gas_meter_sharp,
          iconData4: Icons.person,
        ),
      ),
    );
  }
}
