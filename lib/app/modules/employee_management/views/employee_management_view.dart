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
    // Scaffold is a basic material design layout structure.
    return Scaffold(
      // AppBar is a material design app bar.
      appBar: AppBar(
        // If departmentName is not "Admin", hide the toolbar by setting its height to 0, otherwise set it to default height.
        toolbarHeight: (departmentName.value != "Admin") ? 0 : kToolbarHeight,
        // If departmentName is not "Admin", make the app bar transparent, otherwise set it to blue.
        backgroundColor: (departmentName.value != "Admin")
            ? Colors.transparent
            : Colors.blue,
        // If departmentName is not "Admin", show an empty title, otherwise set it to "Employee Management".
        title: (departmentName.value != "Admin")
            ? const Text("")
            : const Text("Employee Management"),
        // Center the title within the app bar.
        centerTitle: true,
        // Set the elevation of the app bar to 0 (no shadow).
        elevation: 0,
      ),
      // The body of the scaffold.
      body: (departmentName.value == "Admin")
          ? GridView(
        // Padding for the grid view.
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // Key for the grid view.
        key: controller.gridViewKey,
        // Controller for the grid view.
        controller: controller.scrollController,
        // Grid delegate to control the grid layout.
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
        ),
        // Generate a list of SelectCard widgets based on controller.choices.
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

