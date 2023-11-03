import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/branch_wise_complain_controller.dart';
import 'package:photo_view/photo_view.dart';
import '../../../../../data/constants.dart';
import '../../../../../data/widgets.dart';

import 'package:intl/intl.dart';

class BranchWiseComplainView extends GetView<BranchWiseComplainController> {
   BranchWiseComplainView({Key? key}) : super(key: key);

  final branchWiseComplainController = Get.put(BranchWiseComplainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 10),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(onPressed: (){
                    convertToExcel(jsonList: controller.jsonList,fileName: "${controller.selectedBranchName} BranchWiseComplain", jsonKey: "complain");
                  }, icon: const Icon(Icons.download_rounded) , iconSize: 35 , color: Colors.blue,)),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15 , top: 10,bottom: 0),
              child: Obx(() => (controller.branchDataList.isEmpty)
                  ? const Center(
                child: Text("No Data Found"),
              )
                  : Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20,),
                child: TextFormWidget(
                    dropDownValue: controller.branchDataList[0]["branch_name"],
                    dropDown: true,
                    titleText: "Branch",
                    dropDownOnChanged: (newValue) {
                      // controller.upsReadingController.selectedBranch(newValue.toString());
                    },
                    dropDownItems: controller.branchDataList.map((branch) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          controller.selectedBranchName.value = branch['branch_name'];
                          controller.selectedBranchId.value = branch['branch_id'];
                          print(controller.selectedBranchId.value);
                          controller.getComplains(branchId: controller.selectedBranchId.value);
                        },
                        value: branch['branch_name'],
                        child: Text(branch['branch_name']),
                      );
                    }).toList()),
              )),
            ),
            Expanded(
              child: Obx(() {
                return controller.isLoading.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : controller.complainsDataList.isEmpty
                    ? const Center(
                  child: Text("No Data Found"),
                )
                    : ListView.builder(
                    itemCount: controller.complainsDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Card(
                          color: controller.complainsDataList[index].status == 2
                              ? Colors.greenAccent
                              : controller.complainsDataList[index].status == 1
                              ? Colors.yellow.shade200
                              : Colors.indigo.shade100,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.green.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            openEditDialog(
                                              context: context,
                                              index: index,
                                              machineName: controller
                                                  .complainsDataList[index]
                                                  .machineName!,
                                              machineNo: controller
                                                  .complainsDataList[index]
                                                  .machineNo!,
                                              problemDescription: controller
                                                  .complainsDataList[index]
                                                  .problemDescription!,
                                              problems: controller
                                                  .complainsDataList[index]
                                                  .problems!,
                                              photos: controller
                                                  .complainsDataList[index]
                                                  .photos!,
                                              complainId: controller
                                                  .complainsDataList[index]
                                                  .complainId!,
                                            );
                                          },
                                          icon:
                                          const Icon(Icons.edit),
                                          color: Colors.blue,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteComplain(context: context,
                                              complainId: controller
                                                  .complainsDataList[index]
                                                  .complainId!,);
                                          },
                                          icon: const Icon(
                                              Icons.delete),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                MyTextWidget(
                                  title: "Date",
                                  body: controller.complainsDataList[index]
                                      .createdOn!,
                                  isLines: false,
                                ),
                                MyTextWidget(
                                  title: "Ticket No",
                                  body: controller
                                      .complainsDataList[index]
                                      .ticketNo!,
                                  isLines: false,
                                ),
                                MyTextWidget(
                                  title: "Issuer",
                                  body: controller
                                      .complainsDataList[index]
                                      .userName!,
                                  isLines: false,
                                ),
                                MyTextWidget(
                                  title: "Machine Name",
                                  body: controller
                                      .complainsDataList[index]
                                      .machineName!,
                                  isLines: false,
                                ),
                                MyTextWidget(
                                  title: "Machine Number",
                                  body: controller
                                      .complainsDataList[index]
                                      .machineNo!,
                                  isLines: false,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [

                                      (controller.complainsDataList[index]
                                          .problems!.isEmpty)
                                          ? Container()
                                          : Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            child: const Padding(
                                              padding:
                                              EdgeInsets.all(8.0),
                                              child: Text("Problems : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                          ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller
                                                .complainsDataList[index]
                                                .problems!.length,
                                            itemBuilder: (context,
                                                problemIndex) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.cyan,
                                                      borderRadius: BorderRadius
                                                          .circular(10)),
                                                  child: Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .all(8.0),
                                                      child: Text(controller
                                                          .complainsDataList[index]
                                                          .problems![problemIndex],
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight
                                                                  .w500,
                                                              fontSize:
                                                              18))),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),

                                      (controller.complainsDataList[index]
                                          .solvedProblems!.isEmpty)
                                          ? Container()
                                          : Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: const Padding(
                                          padding:
                                          EdgeInsets.all(8.0),
                                          child: Text("Solved Problems : ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),

                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .complainsDataList[index]
                                            .solvedProblems!.length,
                                        itemBuilder: (context, solvedIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius: BorderRadius
                                                      .circular(10)),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: Text(
                                                      controller
                                                          .complainsDataList[index]
                                                          .solvedProblems![solvedIndex],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .w500,
                                                          fontSize: 18))),
                                            ),
                                          );
                                        },
                                      ),

                                      (controller.complainsDataList[index]
                                          .problemDescription == '')
                                          ? Container()
                                          : Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10)),
                                            child: const Padding(
                                              padding:
                                              EdgeInsets.all(8.0),
                                              child: Text(
                                                  "Problems Description : ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                          Card(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Text(controller
                                                  .complainsDataList[index]
                                                  .problemDescription!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      fontSize: 18,
                                                      color:
                                                      Colors.orange)),
                                            ),
                                          ),
                                        ],
                                      ),


                                      Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10)),
                                        child: const Padding(
                                          padding:
                                          EdgeInsets.all(8.0),
                                          child: Text(
                                              "Engineer Assigned For the Work : ",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),

                                      Obx(
                                            () =>
                                        (controller.complainsDataList[index]
                                            .engineers!.isEmpty)
                                            ? const Padding(
                                          padding:
                                          EdgeInsets.all(
                                              8.0),
                                          child: Text(
                                              "No Engineer Assigned Yet",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.red)),
                                        )
                                            : ListView.builder(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller
                                              .complainsDataList[index]
                                              .engineers!.length,
                                          itemBuilder: (context,
                                              engineerIndex) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.indigo,
                                                    borderRadius: BorderRadius
                                                        .circular(10)),
                                                child: Padding(
                                                    padding: const EdgeInsets
                                                        .all(8.0),
                                                    child: Text(controller
                                                        .complainsDataList[index]
                                                        .engineers![engineerIndex]
                                                        .toString(),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .w500,
                                                            fontSize: 18,
                                                            color: Colors
                                                                .white))),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                        const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // Adjust the number of columns as needed
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                        ),
                                        itemCount: controller
                                            .complainsDataList[index].photos!
                                            .length,
                                        itemBuilder:
                                            (context, photoIndex) {
                                          return GestureDetector(
                                            onTap: () {
                                              showBottomSheet(context: context,
                                                  builder: (context) {
                                                    return PhotoView(
                                                      imageProvider: NetworkImage(controller.complainsDataList[index].photos![photoIndex]),);
                                                  });
                                            },
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Image.network(
                                                controller.complainsDataList[index].photos![photoIndex],
                                                fit: BoxFit.fill,
                                                height: 100,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
          ],
        )
    );
  }
  void deleteComplain(
      {required BuildContext context, required int complainId}) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteComplain(complainId: complainId);
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

  void openEditDialog(
      {required BuildContext context, required int complainId, required int index, required String machineName, required String machineNo, required String problemDescription, required List<
          String> problems, required List<String> photos}) {
    controller.machineNameController.text = machineName;
    controller.machineNoController.text = machineNo;
    controller.descriptionController.text = problemDescription;

    controller.newList = problems;
    var checkList = <bool>[].obs;
    controller.problem.clear();
    controller.problem.addAll(problems);

    controller.isCheckedList.addAll(
        List<bool>.generate(controller.problemsDataList.length, (index) {
          final item = controller.problemsDataList[index].description;
          final existsInNewList = controller.newList.contains(item);
          checkList.add(existsInNewList);
          return existsInNewList;
        }));
    showBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormWidget(
                        dropDown: false,
                        titleText: "Machine No : ",
                        textController: controller.machineNoController),
                    TextFormWidget(
                        dropDown: false,
                        titleText: "Machine Name",
                        textController: controller.machineNameController),
                    TextFormWidget(
                        dropDown: false,
                        titleText: "Problem Description",
                        textController: controller.descriptionController),
                    Card(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              10)),
                      child: const Padding(
                        padding:
                        EdgeInsets.all(8.0),
                        child: Text("Problems : ",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w500,
                                fontSize: 18)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                            () =>
                        (controller.isLoading.value == true)
                            ? const Center(child: CircularProgressIndicator())
                            : (controller.complainsDataList.isEmpty)
                            ? const Center(
                          child: Text("No Problems Defined Yet"),
                        )
                            : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.problemsDataList.length,
                            itemBuilder: (context, index) {
                              return Obx(() {
                                return CheckboxListTile(
                                  // subtitle: Text(controller.isCheckedList[index].toString()),
                                  controlAffinity:
                                  ListTileControlAffinity.leading,
                                  checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  enableFeedback: true,
                                  title: Text(
                                    controller.problemsDataList[index]
                                        .description!,
                                  ),
                                  value: checkList[index],
                                  activeColor: Colors.green,
                                  onChanged: (value) {
                                    checkList[index] = value!;
                                    if (checkList[index] == true) {
                                      controller.problem.add(
                                          controller.problemsDataList[index]
                                              .description!);
                                    }
                                    if (checkList[index] == false) {
                                      controller.problem.remove(
                                          controller.problemsDataList[index]
                                              .description!);
                                    }
                                  },
                                );
                              });
                            }),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.updateData(complainId: complainId);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          fixedSize: Size(MediaQuery
                              .of(context)
                              .size
                              .width, 20)),
                      child: const Text("Submit"),
                    )

                  ]),
            ),
          );
        });
  }
}

