import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../../data/widgets.dart';
import '../controllers/date_wise_pre_run_data_controller.dart';

class DateWisePreRunDataView extends GetView<DateWisePreRunDataController> {
   DateWisePreRunDataView({Key? key}) : super(key: key);
  final dateWisePreRunDataController = Get.put(DateWisePreRunDataController());
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Column(
          children: [
            Row(
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
                        size: 20,
                      ),
                      border: InputBorder.none,

                      constraints:
                      BoxConstraints(maxHeight: 45, maxWidth: w / 2.5),
                    ),
                    type: DateTimePickerType.date,
                    dateMask: 'dd/MM/yyyy',
                    initialValue: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    onChanged: (val) {
                      controller.selectedDate.value = val;
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      controller.formatted = formatter.format(DateTime.parse(controller.selectedDate.value));
                      controller.getPreRunDataDateWise(startDate: controller.formatted);

                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => log(val.toString()),
                  ),
                ),
              ],
            ),
            Obx(
                  () => Expanded(
                  child:controller.isLoading.value == true
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      :(controller.preRunDataList.isEmpty)?const Center(child: Text("No Data Found"),) : ListView.builder(
                      itemCount: controller.preRunDataList.length,
                      itemBuilder: (context, index) {
                        var imageType = "";
                        var imageSide = "";

                        switch (
                        controller.preRunDataList[index].imageType) {
                          case 1:
                            {
                              imageType = "Plotting Image";
                              break;
                            }
                          case 2:
                            {
                              imageType = "Plasma Setted Image";
                              break;
                            }
                        }

                        switch (
                        controller.preRunDataList[index].imageSide) {
                          case 1:
                            {
                              imageSide = "Top View Image";
                              break;
                            }
                          case 2:
                            {
                              imageSide = "Front View Image";
                              break;
                            }
                          case 3:
                            {
                              imageSide = "Right View Image";
                              break;
                            }
                          case 4:
                            {
                              imageSide = "Left View Image";
                              break;
                            }
                        }

                        return Obx(
                              () => (controller.preRunDataList.isEmpty)
                              ? const Center(
                              child: Text(
                                  "No Data found , Please Search for data"))
                              : Card(
                            color: Colors.cyan.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MyTextWidget(
                                    title: "Run No : ",
                                    body:
                                    "${controller.preRunDataList[index].runNoFk}",
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: "Date : ",
                                    body:
                                    "${controller.preRunDataList[index].createdOn}",
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: "Image Type : ",
                                    body: imageType,
                                    isLines: false,
                                  ),
                                  MyTextWidget(
                                    title: "Image Side : ",
                                    body: imageSide,
                                    isLines: false,
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 3),
                                    child: GestureDetector(
                                      onTap: (){
                                        showBottomSheet(context: context,
                                            builder: (context) {
                                              return PhotoView(
                                                imageProvider: NetworkImage(controller.preRunDataList[index].image!),);
                                            });

                                      },
                                        child: Image.network(controller.preRunDataList[index].image!)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
            )
          ],
        ));
  }
}
