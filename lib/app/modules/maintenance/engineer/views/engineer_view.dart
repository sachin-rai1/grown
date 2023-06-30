import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../data/widgets.dart';
import '../controllers/engineer_controller.dart';

class EngineerView extends GetView<EngineerController> {
  EngineerView({Key? key}) : super(key: key);

  final engineerController = Get.put(EngineerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:(privilage.value == "Maintenance Engineer" )?null: AppBar(
          title: const Text('Complain To Be Solve'),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.isLoading.value == true?const Center(child: CircularProgressIndicator()):
          controller.engineerProblemDataList.isEmpty?const Center(child: Text("No Data Found"),): SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.engineerProblemDataList.length,
                    itemBuilder: (context, index) {
                      for (int i = 0; i <
                          controller.engineerProblemDataList[index].photos!
                              .length; i++) {
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Card(
                          color: Colors.indigo.shade100,
                          child: ListTile(
                            onTap: () {},
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.green.shade100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: (){

                                            editStatus(context: context,
                                                problemsAssigned: controller.engineerProblemDataList[index].problemsAssigned!,
                                                uniqueId: controller.engineerProblemDataList[index].uniqueId!,
                                                ticketNo: controller.engineerProblemDataList[index].ticketNo!,
                                                problemsSolved: controller.engineerProblemDataList[index].problemSolved ?? [],
                                            );
                                          },
                                          icon:
                                          const Icon(Icons.edit),
                                          color: Colors.blue,
                                        ),
                                        (privilage.value == "Admin")? IconButton(
                                          onPressed: () {
                                            deleteEngineerComplain(context: context,
                                                uniqueId: controller.engineerProblemDataList[index].uniqueId!,
                                              complainId: controller.engineerProblemDataList[index].complainId!,
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.delete),
                                          color: Colors.red,
                                        ):Container(),
                                      ],
                                    ),
                                  ),
                                ),
                                MyTextWidget(title: "Date",
                                  body: controller
                                      .engineerProblemDataList[index]
                                      .complainTbCreatedOn!.toString(),
                                  isLines: false,),
                                MyTextWidget(title: "Ticket No",
                                  body: controller
                                      .engineerProblemDataList[index].ticketNo!,
                                  isLines: false,),
                                MyTextWidget(title: "Issuer",
                                  body: controller
                                      .engineerProblemDataList[index].userName!,
                                  isLines: false,),
                                MyTextWidget(title: "Machine Name",
                                  body: controller
                                      .engineerProblemDataList[index]
                                      .machineName!,
                                  isLines: false,),
                                MyTextWidget(title: "Machine Number",
                                  body: controller
                                      .engineerProblemDataList[index]
                                      .machineNo!,
                                  isLines: false,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Problems Assigned: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .engineerProblemDataList[index]
                                            .problemsAssigned!.length,
                                        itemBuilder: (context, problemIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius: BorderRadius.circular(
                                                      10)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(controller
                                                      .engineerProblemDataList[index]
                                                      .problemsAssigned![problemIndex],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18))
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      controller.engineerProblemDataList[index].problemSolved!.isEmpty?Container():
                                      Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Problems Solved: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),

                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.engineerProblemDataList[index].problemSolved!.length,
                                        itemBuilder: (context, problemIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.cyan,
                                                  borderRadius: BorderRadius.circular(
                                                      10)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(controller.engineerProblemDataList[index].problemSolved![problemIndex],
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18))
                                              ),
                                            ),
                                          );
                                        },
                                      ),


                                      Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("Problems Description : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(controller
                                              .engineerProblemDataList[index]
                                              .problemDescription!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.orange)),
                                        ),
                                      ),
                                      Card(
                                        margin: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)

                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              "Engineer Assigned For the Work : ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18)),
                                        ),
                                      ),

                                      Obx(() =>
                                      (controller.engineerProblemDataList[index]
                                          .otherEngineers!.isEmpty) ?
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("No Engineer Assigned Yet",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                color: Colors.red)),
                                      ) :
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller
                                            .engineerProblemDataList[index]
                                            .otherEngineers!.length,
                                        itemBuilder: (context, engineerIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius: BorderRadius.circular(
                                                      10)
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(controller
                                                      .engineerProblemDataList[index]
                                                      .otherEngineers![engineerIndex]
                                                      .toString(),
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18,
                                                          color: Colors.white))
                                              ),
                                            ),
                                          );
                                        },
                                      ),),
                                      GridView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          // Adjust the number of columns as needed
                                          crossAxisSpacing: 8.0,
                                          mainAxisSpacing: 8.0,
                                        ),
                                        itemCount: controller
                                            .engineerProblemDataList[index].photos!.length,
                                        itemBuilder: (context, photoIndex) {
                                          return GestureDetector(
                                          onTap: () {
                                            showBottomSheet(context: context,
                                                builder: (context) {
                                                  return PhotoView(
                                                    imageProvider: NetworkImage(controller.engineerProblemDataList[index].photos![photoIndex],),);
                                                });
                                          },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.network(
                                                controller
                                                    .engineerProblemDataList[index]
                                                    .photos![photoIndex],
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
                    }),

              ],
            ),
          );
        })
    );
  }

  void editStatus({required BuildContext context , required List<String> problemsAssigned ,required List<String> problemsSolved,  required int uniqueId , required String ticketNo}){
    showBottomSheet(context: context, builder: (context){

      controller.descriptionController.clear();
      controller.problem.clear();
      controller.problem.addAll(problemsSolved);


      var checkList = <bool>[].obs;

      controller.isCheckedList.addAll(List<bool>.generate(problemsAssigned.length, (index) {
        final item = problemsAssigned[index];
        final existsInNewList = problemsSolved.contains(item);
        checkList.add(existsInNewList);
        return existsInNewList;
      }));
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            MyTextWidget(title: "Ticket No : " , body: ticketNo,isLines:false),
            TextFormWidget(dropDown: false, titleText: "Any Description", textController: controller.descriptionController,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                    () =>
                (controller.isLoading.value == true)
                    ? const Center(child: CircularProgressIndicator())
                    : (controller.engineerProblemDataList.isEmpty)
                    ? const Center(
                  child: Text("No Problems Defined Yet"),
                )
                    : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: problemsAssigned.length,
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
                            problemsAssigned[index],
                          ),
                          value: checkList[index],
                          activeColor: Colors.green,
                          onChanged: (value) {
                            checkList[index] = value!;
                            if (checkList[index] == true) {
                              controller.problem.add(problemsAssigned[index]);
                            }
                            if (checkList[index] ==
                                false) {
                              controller.problem.remove(problemsAssigned[index]);
                            }
                          },
                        );
                      });
                    }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(problemsAssigned.length == controller.problem.length){
                 controller.status.value = 2;
                }
                else{
                  controller.status.value = 1;
                }
                controller.updateStatus(uniqueId:uniqueId);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: Size(MediaQuery
                      .of(context)
                      .size
                      .width, 20)),
              child: const Text("Submit"),
            )
          ],
        ),
      );
    });
  }

  void deleteEngineerComplain({required BuildContext context, required int uniqueId , required int complainId}) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteEngineerComplain(uniqueId:uniqueId, complainId: complainId);
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
