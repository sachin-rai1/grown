import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../data/constants.dart';
import '../../../../../data/widgets.dart';
import '../controllers/special_skill_lab_employee_management_controller.dart';

class SpecialSkillLabEmployeeManagementView
    extends GetView<SpecialSkillLabEmployeeManagementController> {
   SpecialSkillLabEmployeeManagementView({Key? key}) : super(key: key);
  final specialSkillLabEmployeeManagementController = Get.put(SpecialSkillLabEmployeeManagementController());
  @override
  Widget build(BuildContext context) {
    // RxList<String> dropdownValues = <String>[].obs; // Store the values for each dropdown field

    // void addDropdownField() {
    //   dropdownValues.add('Option 1');
    // }
    //
    // void removeDropdownField() {
    //   if (dropdownValues.isNotEmpty) {
    //     dropdownValues.removeLast();
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.argSkillName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     DropdownButtonFormField<String>(
          //       decoration: InputDecoration(
          //           constraints: BoxConstraints(maxWidth: w/1.5 )
          //       ),
          //       value: 'Option 1',
          //       onChanged: (newValue) {
          //         // dropdownValues[0] = newValue!;
          //       },
          //       items: const [
          //         DropdownMenuItem(
          //           value: 'Option 1',
          //           child: Text('Option 1'),
          //         ),
          //         DropdownMenuItem(
          //           value: 'Option 2',
          //           child: Text('Option 2'),
          //         ),
          //         DropdownMenuItem(
          //           value: 'Option 3',
          //           child: Text('Option 3'),
          //         ),
          //       ],
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         addDropdownField();
          //       },
          //       child: const Icon(Icons.add_circle),
          //     ),
          //     ElevatedButton(
          //       onPressed: () {
          //         removeDropdownField();
          //       },
          //       child: const Icon(Icons.remove_circle),
          //     ),
          //   ],
          // ),
          //
          // // Render the dropdown fields based on the stored values
          // for (int i = 0; i < dropdownValues.length; i++)
          //   Row(
          //     children: [
          //       DropdownButtonFormField<String>(
          //         decoration: InputDecoration(
          //           constraints: BoxConstraints(maxWidth: w/1.5 )
          //         ),
          //         value: dropdownValues[i],
          //         onChanged: (newValue) {
          //           dropdownValues[i] = newValue!;
          //         },
          //         items: const [
          //           DropdownMenuItem(
          //             value: 'Option 1',
          //             child: Text('Option 1'),
          //           ),
          //           DropdownMenuItem(
          //             value: 'Option 2',
          //             child: Text('Option 2'),
          //           ),
          //           DropdownMenuItem(
          //             value: 'Option 3',
          //             child: Text('Option 3'),
          //           ),
          //         ],
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           addDropdownField();
          //         },
          //         child: const Icon(Icons.add_circle),
          //       ),
          //       ElevatedButton(
          //         onPressed: () {
          //           removeDropdownField();
          //         },
          //         child: const Icon(Icons.remove_circle),
          //       ),
          //     ],
          //   ),
          Expanded(
            child: Obx(
                  () => (controller.isLoading.value == true)
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : (controller.employees.isEmpty)
                  ?  const Center(
                  child: Text(
                    "No Specialized Person Found",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ))
                  : ListView.builder(
                  itemCount: controller.employees.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          controller.getBranches();
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Employee Name :  ${controller.employees[index].empName}"),
                                    Text(
                                        "Branch Name :  ${controller.employees[index].branchName}"),
                                    Text(
                                        "Designation :  ${controller.employees[index].designationName}"),
                                    (controller.employees[index]
                                        .ssName ==
                                        null)
                                        ? Container()
                                        : Text(
                                        "Special Skill : ${controller.employees[index].ssName}"),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    (privilage.value == "Admin" ||
                                        privilage.value == "Editor")
                                        ? GestureDetector(
                                        onTap: () {
                                          controller.designationId.value = controller.employees[index].designationId!;controller.branchId.value = controller.employees[index].branchId!;controller.specialSkillId.value = controller.employees[index].ssId!;controller.hintText.value = controller.employees[index].empName!;updateEmployee(context, controller.employees[index].empId!, controller.hintText.value, controller.employees[index].branchName!, controller.employees[index].designationName!, controller.employees[index].ssName);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors
                                              .deepPurpleAccent,
                                        ))
                                        : Container(),
                                    (privilage.value == "Admin")
                                        ? GestureDetector(
                                        onTap: () {
                                          deleteEmployee(
                                              context,
                                              controller
                                                  .employees[index]
                                                  .empId!);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ))
                                        : Container(),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
      floatingActionButton:
      (privilage.value == "Admin" || privilage.value == "Editor")
          ? FloatingActionButton(
        onPressed: () {
          addEmployee(context);
        },
        child: const Icon(
          Icons.add_circle,
          size: 40,
        ),
      )
          : Container(),
    );
  }

  void updateEmployee(BuildContext context, int empId, String hintText,
      String branchName, String designationName, dynamic skillName) {
    AlertDialog alert = AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            controller.updateEmployee(empId);
          },
          child: const Text("Submit"),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("Cancel"),
        )
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(
            textHintStyle: const TextStyle(color: Colors.black87),
            textController: controller.updateNameController,
            dropDown: false,
            titleText: "Employee Name",
            hintText: hintText,
          ),
          Obx(() => TextFormWidget(
              dropDownValue: branchName,
              dropDown: true,
              titleText: "Branch",
              dropDownOnChanged: (newValue) {
                controller.selectedBranch(newValue.toString());
              },
              dropDownItems: controller.branchData.map((branch) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.branchId.value = branch['branch_id'];


                  },
                  value: branch['branch_name'],
                  child: Text(branch['branch_name']),
                );
              }).toList())),
          Obx(() => TextFormWidget(
              dropDownValue: designationName,
              dropDown: true,
              titleText: "Designation",
              dropDownOnChanged: (newValue) {
                // controller.selectedBranch(newValue.toString());
                // controller.designationId.value = controller.employees[index].designationId!;
              },
              dropDownItems: controller.designationData.map((designation) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.designationId.value =
                    designation['designation_id'];
                  },
                  value: designation['designation_name'],
                  child: Text(designation['designation_name']),
                );
              }).toList())),
          Obx(() => TextFormWidget(
              dropDownValue: (skillName == null) ? null : skillName,
              dropDown: true,
              titleText: "Special Skill",
              dropDownOnChanged: (newValue) {
                controller.selectedBranch(newValue.toString());
              },
              dropDownItems: controller.specialSkillData.map((designation) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.specialSkillId.value = designation['ss_id'];

                  },
                  value: designation['ss_name'],
                  child: Text(designation['ss_name']),
                );
              }).toList())),
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void addEmployee(BuildContext context) {


    AlertDialog alert = AlertDialog(
        actions: [
          ElevatedButton(
            onPressed: () {
              controller.addEmployee();
            },
            child: const Text("Submit"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel"),
          )
        ],
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormWidget(
            textController: controller.nameController,
            dropDown: false,
            titleText: "Employee Name",
          ),
          Obx(() => TextFormWidget(
              dropDownValue: controller.argBranchName.toString(),
              dropDown: true,
              titleText: "Branch",
              dropDownOnChanged: (newValue) {
                controller.selectedBranch(newValue.toString());
              },
              dropDownItems: controller.branchData.map((branch) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.branchId.value = branch['branch_id'];
                  },
                  value: branch['branch_name'],
                  child: Text(branch['branch_name']),
                );
              }).toList())),
          Obx(() => TextFormWidget(
              dropDown: true,
              titleText: "Designation",
              dropDownOnChanged: (newValue) {
                // controller.selectedBranch(newValue.toString());
                // controller.designationId.value = controller.employees[index].designationId!;
              },
              dropDownItems: controller.designationData.map((designation) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.designationId.value =
                    designation['designation_id'];
                  },
                  value: designation['designation_name'],
                  child: Text(designation['designation_name']),
                );
              }).toList())),
          Obx(() => TextFormWidget(
              dropDownValue: controller.argSkillName.toString(),
              dropDown: true,
              titleText: "Special Skill",
              dropDownOnChanged: (newValue) {
                controller.selectedBranch(newValue.toString());
              },
              dropDownItems: controller.specialSkillData.map((designation) {
                return DropdownMenuItem<String>(
                  onTap: () {
                    controller.specialSkillId = designation['ss_id'];
                  },
                  value: designation['ss_name'],
                  child: Text(designation['ss_name']),
                );
              }).toList())),

        ]));
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void deleteEmployee(BuildContext context, int id) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteEmployee(id);
            },
            child: const Text("Confirm")),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel")),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
