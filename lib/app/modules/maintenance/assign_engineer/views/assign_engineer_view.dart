import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../data/widgets.dart';
import '../controllers/assign_engineer_controller.dart';

class AssignEngineerView extends GetView<AssignEngineerController> {
  AssignEngineerView({Key? key}) : super(key: key);
  final assignEngineerController = Get.put(AssignEngineerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Complain'),
          centerTitle: true,
        ),
        body: Obx(() {
          return controller.isLoading.value == true?const Center(child: CircularProgressIndicator()):
          controller.complainsDataList.isEmpty?const Center(child: Text("No Data Found"),): SingleChildScrollView(
            child: Column(
              children: [
                controller.isLoading.value == true ? const Center(
                    child: CircularProgressIndicator()) :
                controller.complainsDataList.isEmpty ? const Center(
                  child: Text("No Un-Assigned Complain Found"),) :
                Obx(()=>(controller.isLoading.value == true)?const CircularProgressIndicator():
                   ListView.builder(
                    reverse: true,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.complainsDataList.length,
                      itemBuilder: (context, index) {
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
                                  MyTextWidget(title: "Date",
                                    body: controller.complainsDataList[index]
                                        .date!,
                                    isLines: false,),
                                  MyTextWidget(title: "Ticket No",
                                    body: controller.complainsDataList[index]
                                        .ticketNo!,
                                    isLines: false,),
                                  MyTextWidget(title: "Issuer",
                                    body: controller.complainsDataList[index]
                                        .userName!,
                                    isLines: false,),
                                  MyTextWidget(title: "Machine Name",
                                    body: controller.complainsDataList[index]
                                        .machineName!,
                                    isLines: false,),
                                  MyTextWidget(title: "Machine Number",
                                    body: controller.complainsDataList[index]
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
                                            child: Text("Problems : ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18)),
                                          ),
                                        ),
                                        ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller.complainsDataList[index].problems!.length,
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
                                                        .complainsDataList[index].problems![problemIndex],
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
                                            child: Text(
                                                controller.complainsDataList[index]
                                                    .problemDescription!,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.orange)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Obx(
                                                () =>
                                            (controller.isLoading.value == true)
                                                ? const Center(
                                                child: CircularProgressIndicator())
                                                : (controller.engineerDataList.isEmpty)
                                                ? const Center(
                                              child: Text("No Engineers Found"),
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
                                                        borderRadius: BorderRadius
                                                            .circular(2),
                                                      ),
                                                      enableFeedback: true,
                                                      title: Text(
                                                        controller.engineerDataList[index].engineers!,
                                                      ),
                                                      value: controller.isCheckedList[index],
                                                      activeColor: Colors.green,
                                                      onChanged: (value) {
                                                        controller.isCheckedList[index] = value!;
                                                        if (controller.isCheckedList[index] == true) {
                                                          controller.engineers.add(controller.engineerDataList[index].engineers!);
                                                          controller.engineerIdList.add(controller.engineerDataList[index].userId!);
                                                          controller.engineerMails.add(controller.engineerDataList[index].userEmail!);
                                                        }
                                                        if (controller
                                                            .isCheckedList[index] ==
                                                            false) {
                                                          controller.engineers.remove(controller.engineerDataList[index].engineers!);
                                                          controller.engineerIdList.remove(controller.engineerDataList[index].userId!);
                                                          controller.engineerMails.remove(controller.engineerDataList[index].userEmail!);

                                                        }
                                                        log(controller.engineers.join(","));
                                                        log(controller.engineerIdList.toString());
                                                      },
                                                    );
                                                  });
                                                }),
                                          ),
                                        ),
                                        GridView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            // Adjust the number of columns as needed
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8.0,
                                          ),
                                          itemCount: controller.complainsDataList[index].photos!.length,
                                          itemBuilder: (context, photoIndex) {
                                            return GestureDetector(
                                              onTap: (){
                                                showBottomSheet(context: context, builder: (context){
                                                  return PhotoView(imageProvider: NetworkImage(controller.complainsDataList[index].photos![photoIndex]),);
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Image.network(
                                                  controller.complainsDataList[index]
                                                      .photos![photoIndex],
                                                  fit: BoxFit.fill,
                                                  height: 100,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.assignEngineer(
                                                complainId: controller.complainsDataList[index].complainId!,
                                                ticketNo: controller.complainsDataList[index].ticketNo!,
                                              machineNo: controller.complainsDataList[index].machineNo!,
                                              machineName: controller.complainsDataList[index].machineName!

                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.amber,
                                              fixedSize: Size(MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width, 20)),
                                          child: const Text("Assign Engineer"),
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
                ),

              ],
            ),
          );
        })
    );
  }
}
