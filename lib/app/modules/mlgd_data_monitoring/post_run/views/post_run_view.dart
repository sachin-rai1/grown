import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/post_run_controller.dart';

class PostRunView extends GetView<PostRunController> {
  PostRunView({Key? key}) : super(key: key);
  final postRunController = Get.put(PostRunController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return TextBoxWidget(
                    controller: controller.runNoController,
                    title: "Run No",
                    suffixIcon: controller.isRunNoLoading.value == true
                        ? const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : controller.runNoStatus.value == 200
                            ? const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 30,
                              )
                            : const Icon(
                                Icons.cancel_outlined,
                                color: Colors.red,
                                size: 30,
                              ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Running No';
                      }
                      return null;
                    },
                    onChanged: (data) {
                      controller.searchRunNoData(
                          runNo: controller.runNoController.text == ''
                              ? 0
                              : int.parse(controller.runNoController.text));
                    },
                  );
                }),
                TextBoxWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter final Height';
                    }
                    return null;
                  },
                  controller: controller.finalHeightController,
                  title: "Final Height",
                ),
                TextFormWidget(
                  dropDownValue: controller.selectedObjective.value,
                  dropDown: true,
                  titleText: "Objective",
                  dropDownOnChanged: (value) {
                    controller.selectedObjective.value = value.toString();
                  },
                  dropDownItems:
                      controller.objectiveDropDownItems.map((objective) {
                    return DropdownMenuItem(
                        value: objective, child: Text(objective));
                  }).toList(),
                ),
                TextBoxWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter final Weight';
                    }
                    return null;
                  },
                  controller: controller.finalWeightController,
                  title: "Final Weight",
                ),
                TextFormWidget(
                  dropDownValue: controller.selectedShutDownReason.value,
                  dropDown: true,
                  titleText: "Shut Down Reason",
                  dropDownOnChanged: (value) {
                    controller.selectedShutDownReason.value = value.toString();
                  },
                  dropDownItems: controller.shutDownDropDownItems.map((reason) {
                    return DropdownMenuItem(value: reason, child: Text(reason));
                  }).toList(),
                ),
                TextBoxWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Remarks';
                    }
                    return null;
                  },
                  controller: controller.remarksController,
                  title: "Remarks",
                ),
                ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      if (controller.runNoStatus.value != 200) {
                        showToastError(msg: "Wrong Run No");
                      } else {
                        controller.addPostRunData();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 2, 20)),
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
