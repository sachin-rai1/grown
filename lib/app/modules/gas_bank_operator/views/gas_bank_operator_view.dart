import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
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
        bottomNavigationBar: MyBottomNavigation(),
      ),
    );
  }
}
