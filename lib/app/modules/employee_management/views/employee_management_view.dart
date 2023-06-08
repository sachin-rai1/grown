import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/employee_management/electrical_employee_management/views/electrical_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/gas_employee_management/views/gas_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/it_employee_management/views/it_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/lab_employee_management/views/lab_employee_management_view.dart';

import '../../../data/widgets.dart';
import '../controllers/employee_management_controller.dart';

class EmployeeManagementView extends GetView<EmployeeManagementController> {
  EmployeeManagementView({Key? key}) : super(key: key);

  final employeeManagementController = Get.put(EmployeeManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: (departmentName.value != "Admin") ? 0 : kToolbarHeight,
        backgroundColor: (departmentName.value != "Admin")
            ? Colors.transparent
            : Colors.blue,
        title: (departmentName.value != "Admin")
            ? const Text("")
            : const Text("Employee Management"),
        centerTitle: true,
        elevation: 0,
      ),
      body: (departmentName.value == "Admin")
          ? GridView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              key: controller.gridViewKey,
              controller: controller.scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 15,
              ),
              children: List.generate(controller.choices.length, (index) {
                return Center(
                    child: SelectCard(choice: controller.choices[index]));
              }),
            )
          : (departmentName.value == "ELECTRICAL")
              ? const ElectricalEmployeeManagementView()
              : (departmentName.value == "Lab")
                  ? LabEmployeeManagementView()
                  : (departmentName.value == "IT")
                      ? const ItEmployeeManagementView()
                      : (departmentName.value == "GAS")
                          ? const GasEmployeeManagementView()
                          : Container(),
    );
  }
}
