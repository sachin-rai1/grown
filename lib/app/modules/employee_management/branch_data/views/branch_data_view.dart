import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../controllers/branch_data_controller.dart';

class BranchDataView extends GetView<BranchDataController> {
   BranchDataView({Key? key}) : super(key: key);
  final branchDataController = Get.put(BranchDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BranchDataView'),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              // homeController.fetchBranches();
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Obx(
            () =>(controller.isLoading.value == true)?const Center(child: CircularProgressIndicator()): (controller.branchData.isEmpty)
            ? Container()
            : ListView.builder(
            itemCount: controller.branchData.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Branch Id : ${controller.branchData[index].branchId!}"),
                          Text(
                              "Branch Name : ${controller.branchData[index].branchName}"),
                          Text(
                              "No. of Machines :${controller.branchData[index].noOfMachines}"),
                          Text(
                              "Floor : ${controller.branchData[index].floor}"),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              updateBranch(
                                  context,
                                  controller.branchData[index].branchId!,
                                  controller.branchData[index].branchName!,
                                  controller.branchData[index].noOfMachines.toString(), controller.branchData[index].floor.toString());
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          (privilage.value == "Admin")? InkWell(
                            onTap: () {
                              deleteBranch(context,
                                  controller.branchData[index].branchId!);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                          ):Container()
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: (privilage.value == "Admin")
          ? FloatingActionButton(
        onPressed: () {
          addBranch(context);
        },
        child: const Icon(
          Icons.add_circle,
          size: 40,
        ),
      )
          : Container(),
    );
  }

  void addBranch(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
        actions: [
          ElevatedButton(
              onPressed: () {
                controller.addBranch();
              },
              child: const Text("Submit")),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormWidget(
              dropDown: false,
              titleText: "Branch Name",
              textController: controller.branchNameController,
            ),
            TextFormWidget(
              dropDown: false,
              titleText: "No of Machines",
              textController: controller.noOfMachinesController,
            ),
            TextFormWidget(
              dropDown: false,
              titleText: "Floor",
              textController: controller.floorController,
            ),
          ],
        ));
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  void updateBranch(BuildContext context, int id, String branchName, String noOfMachines, String floor) {
    AlertDialog alertDialog = AlertDialog(
        actions: [
          ElevatedButton(
              onPressed: () {
                controller.updateBranch(
                    id,
                    (controller.updateBranchNameController.text == "")
                        ? branchName
                        : controller.updateBranchNameController.text,
                    (controller.updateNoOfMachinesController.text == "")
                        ? noOfMachines
                        : controller.updateNoOfMachinesController.text,
                    (controller.updateFloorController.text == "")
                        ? floor
                        : controller.updateFloorController.text);
              },
              child: const Text("Submit")),
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Cancel")),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormWidget(
              dropDown: false,
              titleText: "Branch Name",
              textController: controller.updateBranchNameController,
              hintText: branchName,
              textHintStyle: const TextStyle(color: Colors.black87),
            ),
            TextFormWidget(
              dropDown: false,
              titleText: "No of Machines",
              textController: controller.updateNoOfMachinesController,
              hintText: noOfMachines,
              textHintStyle: const TextStyle(color: Colors.black87),
            ),
            TextFormWidget(
              dropDown: false,
              titleText: "Floor",
              textController: controller.updateFloorController,
              hintText: floor,
              textHintStyle: const TextStyle(color: Colors.black87),
            ),
          ],
        ));
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  void deleteBranch(BuildContext context, int id) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteBranch(id);
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
