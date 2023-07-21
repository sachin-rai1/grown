import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../controllers/view_ups_reading_controller.dart';

class ViewUpsReadingDateWiseView extends GetView<ViewUpsReadingDateWiseController> {
  ViewUpsReadingDateWiseView({Key? key}) : super(key: key);
  final viewUpsReadingController = Get.put(ViewUpsReadingDateWiseController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyDateWidget(
                  initialValue: controller.selectedDate.value,
                  onChanged: (val) {
                    controller.selectedDate.value = val;
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');
                    controller.formatted = formatter.format(DateTime.parse(controller.selectedDate.value));
                    controller.fetchUpsReadingDataDateWise(controller.formatted);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(onPressed: (){
                        convertToExcel(jsonList: controller.jsonList,fileName: "UpsReadingDateWise");
                      }, icon: const Icon(Icons.download_rounded) , iconSize: 35 , color: Colors.blue,)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
                  () =>
              (controller.isLoading.value == true)
                  ? const Center(child: CircularProgressIndicator())
                  :(controller.upsReadingDataList.isEmpty)?
              Center(child: Text("No Data Found on ${controller.formatted}" , style: const TextStyle(fontWeight: FontWeight.w600 , fontSize: 16),),):
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.upsReadingDataList.length,
                  itemBuilder: (context, index) {
                    var ledStatus = "";

                    switch (controller.upsReadingDataList[index].ledStatus) {
                      case 1:
                        ledStatus = "Red";
                        break;
                      case 2:
                        ledStatus = "Green";
                        break;
                      case 3:
                        ledStatus = "Orange";
                        break;
                      default:
                        ledStatus = "Error";
                    }
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Card(
                        elevation: 2,
                        color: (ledStatus == "Red")?Colors.red.shade300 : (ledStatus == "Orange")?Colors.orange.shade300:(ledStatus == "Green")?Colors.green.shade300:Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        updateUpsReadingData(context: context,
                                            branchName: controller.upsReadingDataList[index].branchName!,
                                            upsName: controller.upsReadingDataList[index].upsName!,
                                            lur: controller.upsReadingDataList[index].loadsOnUpsR!,
                                            luy: controller.upsReadingDataList[index].loadsOnUpsY!,
                                            lub: controller.upsReadingDataList[index].loadsOnUpsB!,
                                            led: controller.upsReadingDataList[index].ledStatus!.toString().obs,
                                            positive: controller.upsReadingDataList[index].dcPositiveVoltage!,
                                            negative: controller.upsReadingDataList[index].dcNegativeVoltage!,
                                            id: controller.upsReadingDataList[index].readingId!,
                                            branchId: controller.upsReadingDataList[index].branchId!,
                                            upsId: controller.upsReadingDataList[index].upsId!);
                                      },
                                      icon: const Icon(
                                          Icons.mode_edit_outline_outlined)),
                                  IconButton(
                                      onPressed: () {
                                        deleteUpsReadingData(context: context, id: controller.upsReadingDataList[index].readingId!,);
                                      },
                                      icon: const Icon(Icons.delete_sweep)),
                                ],
                              ),
                              MyTextWidget(
                                  title: "Branch  :  ",
                                  isLines: false,
                                  body: controller
                                      .upsReadingDataList[index].branchName),
                              MyTextWidget(
                                title: "UPS :  ",
                                isLines: false,
                                body:
                                controller.upsReadingDataList[index].upsName!,
                              ),
                              MyTextWidget(
                                title: "LOAD ON UPS R  :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].loadsOnUpsR
                                    .toString(),
                              ),
                              MyTextWidget(
                                title: "LOAD ON UPS Y :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].loadsOnUpsY
                                    .toString(),
                              ),
                              MyTextWidget(
                                title: "LOAD ON UPS B :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].loadsOnUpsB
                                    .toString(),
                              ),
                              MyTextWidget(
                                  title: "LED STATUS :  ",
                                  isLines: false,
                                  body: ledStatus),
                              MyTextWidget(
                                title: "DC POSITIVE VOLTAGE :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].dcPositiveVoltage
                                    .toString(),
                              ),
                              MyTextWidget(
                                title: "DC NEGATIVE VOLTAGE :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].dcNegativeVoltage
                                    .toString(),
                              ),
                              MyTextWidget(
                                title: "Date :  ",
                                isLines: false,
                                body: controller
                                    .upsReadingDataList[index].createdOn
                                    .toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
  void deleteUpsReadingData({required BuildContext context,required int id}) {
    AlertDialog alertDialog = AlertDialog(
        contentPadding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
        actions: [
          ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("No")),
          ElevatedButton(onPressed: ()=>controller.deleteUpsReadingData(id: id), style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Yes")),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text("Are You Sure want to delete $id")
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void updateUpsReadingData({
    required BuildContext context,
    required int id,
    required String branchName,
    required String upsName,
    required int lur,
    required int luy,
    required int lub,
    required RxString led,
    required int positive,
    required int negative,
    required int branchId,
    required int upsId,
  }) {
    AlertDialog alertDialog = AlertDialog(
      content: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() =>
            (controller.upsReadingController.branchDataList.isEmpty)
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : TextFormWidget(
              dropDownValue: branchName,
                dropDown: true,
                titleText: "Branch",
                dropDownOnChanged: (newValue) {
                  // controller.upsReadingController.selectedBranch(newValue.toString());
                },
                dropDownItems: controller.upsReadingController.branchDataList
                    .map((branch) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      controller.selectedBranchId.value = branch['branch_id'];
                    },
                    value: branch['branch_name'],
                    child: Text(branch['branch_name']),
                  );
                }).toList())),
            Obx(() =>
            (controller.upsReadingController.upsDataList.isEmpty)
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : TextFormWidget(
              dropDownValue: upsName,
                dropDown: true,
                titleText: "Ups",
                dropDownOnChanged: (newValue) {
                  // controller.selectedBranch(newValue.toString());
                },
                dropDownItems: controller.upsReadingController.upsDataList.map((ups) {
                  return DropdownMenuItem<String>(
                    onTap: () {
                      controller.selectedUpsId.value = ups.upsId!;
                    },
                    value: ups.upsName,
                    child: Text(ups.upsName!),
                  );
                }).toList())),
            TextBoxWidget(
              hintText: lur.toString(),
              title: "Load On Ups R",
              controller: controller.loadOnUpsRController,
            ),
            TextBoxWidget(
              hintText: luy.toString(),
              title: "Load On Ups Y",
              controller: controller.loadOnUpsYController,
            ),
            TextBoxWidget(
              hintText: lub.toString(),
              title: "Load On Ups B",
              controller: controller.loadOnUpsBController,
            ),
            const Text(
              "Led Status",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            Obx(
                  () =>
                  MyRadioList(
                    title: 'Red',
                    value: '1',
                    activeColor: Colors.red,
                    groupValue: led.value,
                    onChanged: (value) {
                      led.value = value.toString();
                      controller.ledStatus.value = value.toString();
                    },
                  ),
            ),
            Obx(
                  () =>
                  MyRadioList(
                    activeColor: Colors.green,
                    title: 'Green',
                    value: '2',
                    groupValue: led.value,
                    onChanged: (value) {
                      led.value = value.toString();
                      controller.ledStatus.value = value.toString();
                    },
                  ),
            ),
            Obx(
                  () =>
                  MyRadioList(
                    activeColor: Colors.orange,
                    title: 'Orange',
                    value: '3',
                    groupValue: led.value,
                    onChanged: (value) {
                      led.value = value.toString();
                      controller.ledStatus.value = value.toString();
                    },
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextBoxWidget(
              hintText: positive.toString(),
              title: "DC Positive Voltage",
              controller: controller.positiveVoltageController,
            ),
            TextBoxWidget(
              hintText: negative.toString(),
              title: "DC Negative Voltage",
              controller: controller.negativeVoltageController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text("Cancel")),
                const SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () => controller.updateUpsReading(id: id, branchId: branchId, upsId: upsId, lur: lur, luy: luy, lub: lub, led: led, positive: positive, negative: negative),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: const Text("Submit")),


              ],
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
