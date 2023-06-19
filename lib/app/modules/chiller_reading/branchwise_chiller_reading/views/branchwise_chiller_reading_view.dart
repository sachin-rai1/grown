import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../../controllers/chiller_reading_controller.dart';
import '../controllers/branchwise_chiller_reading_controller.dart';

class BranchWiseChillerReadingView
    extends GetView<BranchwiseChillerReadingController> {
   BranchWiseChillerReadingView({Key? key}) : super(key: key);

  final branchwiseChillerReadingController = Get.put(BranchwiseChillerReadingController());
   final chillerReadingController = Get.put(ChillerReadingController());
  @override

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15 ,horizontal: 20),
            child: Obx(() =>
            (chillerReadingController.branchDataList.isEmpty)
                ? SizedBox(
                width: (privilage.value == "Admin" ||
                    privilage.value == "Editor")
                    ? w / 1.5
                    : w / 1.2,
                child: const Center(
                  child: CircularProgressIndicator(),
                ))
                : TextFormWidget(
                dropDownValue: chillerReadingController.branchDataList[0]["branch_name"],
                dropDown: true,
                titleText: "Branch",
                dropDownOnChanged: (newValue) {
                  chillerReadingController.selectedBranch(newValue.toString());
                },
                dropDownItems:
                chillerReadingController.branchDataList.map((branch) {
                  return DropdownMenuItem<String>(
                    onTap: () async {
                      controller.selectedBranchId.value = branch['branch_id'];
                      await controller.fetchChillerReading(branchId: controller.selectedBranchId.value);
                    },
                    value: branch['branch_name'],
                    child: Text(branch['branch_name']),
                  );
                }).toList())),
          ),
          Expanded(
            child: Obx(
                  () {
                return controller.isLoading.value == true
                    ? const Center(child: CircularProgressIndicator())
                    : controller.chillerReadingDataList.isEmpty
                    ? const Center(child: Text("No Data Found"))
                    : ListView.builder(

                  itemCount: controller.chillerReadingDataList.length,
                  itemBuilder: (context, index) {
                    var cp1 = "".obs;
                    var cp2 = "".obs;
                    if (controller.chillerReadingDataList[index]
                        .circulationPump1Status ==
                        1) {
                      cp1.value = "ON";
                    } else if (controller
                        .chillerReadingDataList[index]
                        .circulationPump1Status ==
                        0) {
                      cp1.value = "Off";
                    } else {
                      cp1.value = "Undefined";
                    }

                    if (controller.chillerReadingDataList[index]
                        .circulationPump2Status ==
                        1) {
                      cp2.value = "ON";
                    } else if (controller
                        .chillerReadingDataList[index]
                        .circulationPump2Status ==
                        0) {
                      cp2.value = "Off";
                    } else {
                      cp2.value = "Undefined";
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Card(
                        child: ExpansionTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                  child: const Icon(Icons.edit , color: Colors.blue,),
                                  onTap: (){
                                    updateChillerReadingData(
                                        context: context,
                                        readingId: controller.chillerReadingDataList[index].readingId!,
                                        inletTemperature: controller.chillerReadingDataList[index].inletTemperature!.toString(),
                                        outletTemperature: controller.chillerReadingDataList[index].outletTemperature!.toString(),
                                        averageLoad: controller.chillerReadingDataList[index].averageLoad.toString(),
                                      processPumpPressure: controller.chillerReadingDataList[index].processPumpPressure.toString()
                                    );
                                  }),
                              InkWell(
                                  child: const Icon(Icons.delete , color: Colors.red,),
                                  onTap: (){
                                    deleteChillerReadingData(context: context, readingId: controller.chillerReadingDataList[index].readingId!);
                                  }),
                            ],
                          ),
                          maintainState: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.cyan.shade200,
                          onExpansionChanged: (value) async {
                            if (value.toString() == "true") {
                              await controller.fetchChillerCompressorReading(chillerReadingId: controller.chillerReadingDataList[index].readingId);
                              await controller.fetchProcessPumpReading(chillerReadingId: controller.chillerReadingDataList[index].readingId);
                            } else {
                              controller.chillerCompressorDataList.value = [];
                            }
                          },
                          title: Column(
                            children: <Widget>[
                              MyTextWidget(
                                title: 'Branch :',
                                body: controller.chillerReadingDataList[index].branchName!,
                                isLines: false,
                              ),
                              MyTextWidget(
                                title: 'Phase  :',
                                body: controller
                                    .chillerReadingDataList[index]
                                    .phaseName!,
                                isLines: false,
                              ),
                              MyTextWidget(
                                title: 'Chiller  :',
                                body: controller
                                    .chillerReadingDataList[index]
                                    .chillerName,
                                isLines: false,
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Column(
                                children: [
                                  MyTextWidget(
                                    title: 'Inlet Temperature',
                                    body: controller
                                        .chillerReadingDataList[index]
                                        .inletTemperature
                                        .toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Outlet Temperature',
                                    body: controller
                                        .chillerReadingDataList[index]
                                        .outletTemperature
                                        .toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Process Pump Pressure',
                                    body: controller.chillerReadingDataList[index].processPumpPressure.toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Average Load',
                                    body: controller.chillerReadingDataList[index].averageLoad.toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Uploaded On',
                                    body: controller
                                        .chillerReadingDataList[index]
                                        .createdOn
                                        .toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Circulation Pump 1',
                                    colors: cp1.value == "ON"
                                        ? Colors.lightGreenAccent
                                        : cp1.value == "Off"
                                        ? Colors.redAccent
                                        : null,
                                    body: cp1.value,
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    colors: cp2.value == "ON"
                                        ? Colors.lightGreenAccent
                                        : cp2.value == "Off"
                                        ? Colors.redAccent
                                        : null,
                                    title: 'Circulation Pump 2',
                                    body: cp2.value,
                                    isLines: false,
                                  ),
                                  Obx(() {
                                    return (controller
                                        .isCompressorLoading
                                        .value ==
                                        true)
                                        ? const Center(
                                        child:
                                        CircularProgressIndicator())
                                        : (controller.chillerReadingDataList.isEmpty)
                                        ? Container()
                                        : (controller.chillerCompressorDataList.isEmpty)
                                        ? Container()
                                        : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        const ClampingScrollPhysics(),
                                        itemCount: controller.chillerCompressorDataList.length,
                                        itemBuilder:
                                            (context,
                                            innerIndex) {
                                          var status = "";
                                          if (controller.chillerCompressorDataList[innerIndex].status == 1) {status = "ON";
                                          } else {
                                            status = "OFF";
                                          }
                                          return Column(
                                            children: [
                                              MyTextWidget(
                                                colors: (status == "ON") ? Colors.lightGreenAccent : Colors.redAccent,
                                                title: controller.chillerCompressorDataList[innerIndex].compressorName!,
                                                body: status,
                                                isLines: false,
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                                  Obx(() {
                                    return (controller.isProcessPumpLoading.value == true)
                                        ? const Center(
                                        child:
                                        CircularProgressIndicator())
                                        : (controller.processPumpDataList.isEmpty)
                                        ? Container()
                                        : (controller.processPumpDataList.isEmpty)
                                        ? Container()
                                        : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        const ClampingScrollPhysics(),
                                        itemCount: controller.processPumpDataList.length,
                                        itemBuilder: (context,
                                            processIndex) {
                                          var status = "";
                                          if (controller.processPumpDataList[processIndex].status == 1) {
                                            status = "ON";
                                          } else {
                                            status =
                                            "OFF";
                                          }
                                          return Column(
                                            children: [
                                              MyTextWidget(
                                                colors: (status ==
                                                    "ON")
                                                    ? Colors.lightGreenAccent
                                                    : Colors.redAccent,
                                                title: controller.processPumpDataList[processIndex].processPumpName!,
                                                body: status,
                                                isLines:
                                                false,
                                              ),
                                            ],
                                          );
                                        });
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),


        ],
      ),
    );
  }
   void deleteChillerReadingData({required BuildContext context, required int readingId}){
     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Are you Sure Want to delete"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.deleteChillerReading(readingId: readingId), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Delete")),
         ],
       );
     });
   }

   void updateChillerReadingData(
       {required BuildContext context,
         required int readingId ,
         required String inletTemperature,
         required String outletTemperature ,
         required String averageLoad ,
         required String processPumpPressure,

       })
   {
     controller.inletTemperatureController.text= inletTemperature;
     controller.outletTemperatureController.text= outletTemperature;
     controller.averageLoadController.text= averageLoad;
     controller.processPumpPressureController.text = processPumpPressure;

     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Update Chiller Reading"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
           ElevatedButton(onPressed: ()=>controller.updateChillerReadingData(readingId: readingId), child: const Text("Submit")),

         ],
         content: SingleChildScrollView(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               TextFormWidget(dropDown: false, titleText: "Inlet Temperature" , textController: controller.inletTemperatureController,),
               TextFormWidget(dropDown: false, titleText: "Outlet Temperature" , textController: controller.outletTemperatureController,),
               TextFormWidget(dropDown: false, titleText: "Average Load" , textController: controller.averageLoadController,),
               TextFormWidget(dropDown: false, titleText: "Process Pump Pressure" , textController: controller.processPumpPressureController,),
             ],
           ),
         ),
       );
     });
   }
}
