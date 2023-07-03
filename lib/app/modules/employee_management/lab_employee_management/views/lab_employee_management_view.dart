import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/employee_management/lab_employee_management/designation_lab_employee_management/views/designation_lab_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/lab_employee_management/special_skill_lab_employee_management/views/special_skill_lab_employee_management_view.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../../branch_data/views/branch_data_view.dart';
import '../controllers/lab_employee_management_controller.dart';

class LabEmployeeManagementView
    extends GetView<LabEmployeeManagementController> {
   LabEmployeeManagementView({Key? key}) : super(key: key);
  final labEmployeeManagementController = Get.put(LabEmployeeManagementController());
  @override
  Widget build(BuildContext context) {
    // Get the width of the device screen.
    var w = MediaQuery.of(context).size.width;
    // Build the scaffold widget.
    return Scaffold(
      // AppBar is a material design app bar.
      appBar: AppBar(
        // Set the title of the app bar.
        title: const Text('Team Planning'),
        // Center the title within the app bar.
        centerTitle: true,
        // Set the elevation of the app bar to 0 (no shadow).
        elevation: 0,
      ),
      // The body of the scaffold.
      body: Padding(
        // Padding widget to add padding around its child.
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // RefreshIndicator is a material design widget for implementing pull-to-refresh behavior.
        child: RefreshIndicator(
          // Callback function when a refresh is triggered.
          onRefresh: () {
            return Future(() => controller.onClose());
          },
          // SingleChildScrollView is a widget that allows its child to be scrolled.
          child: SingleChildScrollView(
            child: Column(
              // CrossAxisAlignment.start aligns the children in a column to the start (left) of the cross axis.
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // MainAxisAlignment.spaceBetween positions the children at the start and end of the row with equal space in between.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Obx is an observer widget that rebuilds when the observed Rx variables change.
                    Obx(() => (controller.branchData.isEmpty)
                        ? Container()
                        : TextFormWidget(
                      dropDownValue: controller.branchData[0]["branch_name"],
                      dropDownWidth: (privilage.value == "Admin" ||
                          privilage.value == "Editor")
                          ? w / 1.5
                          : w / 1.2,
                      dropDown: true,
                      titleText: "Branch",
                      dropDownOnChanged: (newValue) {
                        controller.selectedBranch(newValue.toString());
                      },
                      dropDownItems: controller.branchData.map((branch) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            controller.branchId.value = branch['branch_id'];
                            controller.branchId.value =
                                controller.branchId.value;
                            controller.fetchEmployeesByBranchDetails(
                                controller.branchId.value);
                          },
                          value: branch['branch_name'],
                          child: Text(branch['branch_name']),
                        );
                      }).toList(),
                    )),
                    Obx(
                          () => (privilage.value == "Admin" || privilage.value == "Editor")
                          ? InkWell(
                        onTap: () {
                          Get.to(() => BranchDataView());
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Icon(
                            Icons.add_circle,
                            size: 50,
                            color: Colors.blue,
                          ),
                        ),
                      )
                          : Container(),
                    ),
                  ],
                ),
                Obx(() => (controller.totalMachines.value == 0)
                    ? Container()
                    : Text(
                  "Machines :  ${controller.totalMachines.value}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  height: 10,
                ),
                Obx(() => (controller.totalEmployees.value == 0)
                    ? Container()
                    : Text(
                    "Employees  : ${controller.totalEmployees.value} / ${controller.requireEmployees.value} ",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500))),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                      () => (controller.isLoading.value == true)
                      ? const Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.requiredDesignations.length,
                        itemBuilder: (context, index) {
                          var percent = controller.designationDetails[index].count! /
                              num.parse(controller.requiredDesignations[index].count.toString().trim());
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => DesignationLabEmployeeManagementView(), arguments: [
                                  {
                                    "designationId":
                                    controller.requiredDesignations[index].id
                                  },
                                  {"branchId": controller.branchId.value},
                                  {"branchName": controller.selectedBranch.value},
                                  {
                                    "designation": controller.requiredDesignations[index].name
                                  },
                                ]);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: w * 0.5,
                                        child: Text(
                                            "${controller.requiredDesignations[index].name}"),
                                      ),
                                      SizedBox(
                                        width: w * 0.4,
                                        child: Text(
                                            "C.S : ${controller.designationDetails[index].count} / ${controller.requiredDesignations[index].count} "),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LinearPercentIndicator(
                                    width: w / 1.5,
                                    lineHeight: 20.0,
                                    trailing: Text(
                                        "${(controller.designationDetails[index].count! * 100 / num.parse(controller.requiredDesignations[index].count.toString().trim())).toStringAsFixed(2)} %"),
                                    percent: (percent > 1.0) ? 1.0 : percent,
                                    backgroundColor: Colors.green.shade100,
                                    progressColor: (percent > 1.0)
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.requiredSkill.length,
                        itemBuilder: (context, index) {
                          var percent = controller.specialSkill[index].count! /
                              num.parse(controller.requiredSkill[index].count.toString().trim());
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => SpecialSkillLabEmployeeManagementView(), arguments: [
                                  {
                                    "skillId": controller.requiredDesignations[index].id
                                  },
                                  {"branchId": controller.branchId.value},
                                  {"branchName": controller.selectedBranch},
                                  {"skill": controller.requiredSkill[index].name}
                                ]);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: w * 0.5,
                                        child: Text(
                                            "Special Skills : ${controller.requiredSkill[index].name}"),
                                      ),
                                      SizedBox(
                                        width: w * 0.4,
                                        child: Text(
                                            "Current Strength : ${controller.specialSkill[index].count} /${controller.requiredSkill[index].count} "),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LinearPercentIndicator(
                                    width: w / 1.5,
                                    lineHeight: 20.0,
                                    trailing: Text(
                                        "${(controller.specialSkill[index].count! * 100 / num.parse(controller.requiredSkill[index].count.toString().trim())).toStringAsFixed(2)} %"),
                                    percent: (percent > 1.0) ? 1.0 : percent,
                                    backgroundColor: Colors.deepPurpleAccent.shade100,
                                    progressColor: (percent > 1.0)
                                        ? Colors.red
                                        : Colors.deepPurpleAccent,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
