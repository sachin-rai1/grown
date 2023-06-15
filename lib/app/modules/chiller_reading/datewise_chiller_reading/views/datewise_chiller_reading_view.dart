import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/widgets.dart';
import '../controllers/datewise_chiller_reading_controller.dart';

class DateWiseChillerReadingView
    extends GetView<DatewiseChillerReadingController> {
  DateWiseChillerReadingView({Key? key}) : super(key: key);

  final datewiseChillerReadingController =
  Get.put(DatewiseChillerReadingController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Select Date : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Card(
                  elevation: 1,
                  color: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DateTimePicker(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.edit,
                        size: 25,
                      ),
                      border: InputBorder.none,
                      constraints:
                      BoxConstraints(maxHeight: 35, maxWidth: w / 2.5),
                    ),
                    type: DateTimePickerType.date,
                    dateMask: 'dd/MM/yyyy',
                    initialValue: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    onChanged: (val) async {
                      controller.selectedDate.value = val;
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      controller.formatted = formatter.format(
                          DateTime.parse(controller.selectedDate.value));
                      await controller.fetchChillerReading(selectedDate: controller.formatted);
                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => log(val.toString()),
                  ),
                ),
              ],
            ),
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Card(
                        child: ExpansionTile(
                          maintainState: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.cyan.shade200,
                          onExpansionChanged: (value) {
                            if(value.toString() == "true") {
                              controller.fetchChillerCompressorReading(chillerReadingId: controller.chillerReadingDataList[index].readingId);
                            }
                            else{
                              controller.chillerCompressorDataList.value = [];
                            }
                          },
                          title: Column(
                            children: <Widget>[
                              MyTextWidget(
                                title: 'Branch :',
                                body: controller
                                    .chillerReadingDataList[index]
                                    .branchName!,
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
                                body: controller.chillerReadingDataList[index].chillerName,
                                isLines: false,
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10 , right: 10 , bottom: 10),
                              child: Column(
                                children: [
                                  MyTextWidget(
                                    title: 'Inlet Temperature',
                                    body: controller.chillerReadingDataList[index].inletTemperature.toString(),
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
                                    title: 'Average Load',
                                    body: controller
                                        .chillerReadingDataList[index]
                                        .averageLoad
                                        .toString(),
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: 'Uploaded On',
                                    body: controller
                                        .chillerReadingDataList[index]
                                        .createdOn,
                                    isLines: false,
                                  ),
                                  Obx(() {
                                    return(controller.isCompressorLoading.value == true)?
                                    const Center(child: CircularProgressIndicator()):(controller.chillerReadingDataList.isEmpty)?Container():
                                    (controller.chillerCompressorDataList.isEmpty)?
                                     Container():
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        itemCount: controller.chillerCompressorDataList.length,
                                        itemBuilder: (context, innerIndex) {
                                          var status = "";
                                          if (controller.chillerCompressorDataList[innerIndex].status == 1) {
                                            status = "ON";
                                          }
                                          else {
                                            status = "OFF";
                                          }
                                          return Column(
                                            children: [
                                              MyTextWidget(
                                                colors: (status == "ON") ? Colors
                                                    .lightGreenAccent : Colors
                                                    .redAccent,
                                                title: controller
                                                    .chillerCompressorDataList[innerIndex]
                                                    .compressorName!,
                                                body: status,
                                                isLines: false,),
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
  // void getOtherData(BuildContext context){
  //   showModalBottomSheet(context: context, builder: (context){
  //     return Obx(() {
  //       return(controller.isCompressorLoading.value == true)?
  //       const Center(child: CircularProgressIndicator()):(controller.chillerReadingDataList.isEmpty)?Container():
  //       (controller.chillerCompressorDataList.isEmpty)?
  //       const Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
  //         child: MyTextWidget(title: "Please Select a Card to View Compressor" , isLines: false),
  //       ):
  //       Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         child: ListView.builder(
  //             shrinkWrap: true,
  //             physics: const ClampingScrollPhysics(),
  //             itemCount: controller.chillerCompressorDataList.length,
  //             itemBuilder: (context, innerIndex) {
  //               var status = "";
  //               if (controller.chillerCompressorDataList[innerIndex].status == 1) {
  //                 status = "ON";
  //               }
  //               else {
  //                 status = "OFF";
  //               }
  //               return Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: Column(
  //                   children: [
  //                     MyTextWidget(
  //                       colors: (status == "ON") ? Colors
  //                           .lightGreenAccent : Colors
  //                           .redAccent,
  //                       title: controller
  //                           .chillerCompressorDataList[innerIndex]
  //                           .compressorName!,
  //                       body: status,
  //                       isLines: false,),
  //                   ],
  //                 ),
  //               );
  //             }),
  //       );
  //     });
  //   });
  // }
}
