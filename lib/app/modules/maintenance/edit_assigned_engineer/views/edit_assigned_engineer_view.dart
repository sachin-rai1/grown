import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../controllers/edit_assigned_engineer_controller.dart';

class EditAssignedEngineerView extends GetView<EditAssignedEngineerController> {
   EditAssignedEngineerView({Key? key}) : super(key: key);

  final editAssignedEngineerController = Get.put(EditAssignedEngineerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:(privilage.value == "Maintenance Engineer" )?null: AppBar(
          title: const Text('Edit Assigned Engineers'),
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
                      var photos = "";
                      for (int i = 0; i <
                          controller.engineerProblemDataList[index].photos!
                              .length; i++) {
                        photos =
                            controller.engineerProblemDataList[index].photos![i].toString();
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
                                              engineerAssigned: controller.engineerProblemDataList[index].otherEngineers!,
                                              uniqueId: controller.engineerProblemDataList[index].uniqueId!,
                                              ticketNo: controller.engineerProblemDataList[index].ticketNo!,
                                              complainId: controller.engineerProblemDataList[index].complainId!,
                                              machineNo: controller.engineerProblemDataList[index].machineNo!,
                                              machineName: controller.engineerProblemDataList[index].machineName!,
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
                                            .engineerProblemDataList[index].photos!
                                            .length,
                                        itemBuilder: (context, photoIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              controller
                                                  .engineerProblemDataList[index]
                                                  .photos![photoIndex],
                                              fit: BoxFit.fill,
                                              height: 100,
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

   void editStatus({required BuildContext context , required List<String> engineerAssigned ,required int uniqueId , required String ticketNo ,required int complainId , required String machineNo , required String machineName}){
     showBottomSheet(context: context, builder: (context){

       controller.newList = engineerAssigned;
       controller.engineers.clear();
       controller.engineers.addAll(engineerAssigned);


       var checkList = <bool>[].obs;

       controller.isCheckedList.addAll(List<bool>.generate(controller.engineerDataList.length, (index) {
         final item = controller.engineerDataList[index].engineers;
         final existsInNewList = controller.newList.contains(item);
         checkList.add(existsInNewList);
         return existsInNewList;
       }));
       return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
         child: Column(
           children: [
             MyTextWidget(title: "Ticket No : " , body: ticketNo,isLines:false),
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
                     itemCount: controller.engineerDataList.length,
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
                             controller.engineerDataList[index].engineers!,
                           ),
                           value: checkList[index],
                           activeColor: Colors.green,
                           onChanged: (value) {
                             checkList[index] = value!;
                             if (checkList[index] == true) {
                               controller.engineers.add(controller.engineerDataList[index].engineers!);

                               controller.engineerMails.add(controller.engineerDataList[index].userEmail!);
                             }
                             if (checkList[index] ==
                                 false) {
                               controller.engineers.remove(controller.engineerDataList[index].engineers!);
                               controller.engineerMails.remove(controller.engineerDataList[index].userEmail!);
                             }
                             print(controller.engineerMails);
                           },
                         );
                       });
                     }),
               ),
             ),
             ElevatedButton(
               onPressed: () {
                 controller.assignEngineer(complainId: complainId, ticketNo: ticketNo, machineNo: machineNo, machineName: machineName);
               },
               style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.amber,
                   fixedSize: Size(MediaQuery.of(context).size.width, 20)),
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
