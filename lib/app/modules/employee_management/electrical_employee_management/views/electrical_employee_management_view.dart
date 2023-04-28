import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/electrical_employee_management_controller.dart';

class ElectricalEmployeeManagementView
    extends GetView<ElectricalEmployeeManagementController> {
  const ElectricalEmployeeManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElectricalEmployeeManagementView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Coming Soon....',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
