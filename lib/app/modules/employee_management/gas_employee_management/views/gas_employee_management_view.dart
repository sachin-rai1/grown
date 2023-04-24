import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gas_employee_management_controller.dart';

class GasEmployeeManagementView
    extends GetView<GasEmployeeManagementController> {
  const GasEmployeeManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GasEmployeeManagementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GasEmployeeManagementView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
