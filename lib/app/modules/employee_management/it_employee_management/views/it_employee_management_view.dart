import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/it_employee_management_controller.dart';

class ItEmployeeManagementView extends GetView<ItEmployeeManagementController> {
  const ItEmployeeManagementView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ItEmployeeManagementView'),
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
