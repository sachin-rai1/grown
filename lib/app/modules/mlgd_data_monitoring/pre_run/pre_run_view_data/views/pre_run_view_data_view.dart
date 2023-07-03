import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/pre_run_view_data_controller.dart';

class PreRunViewDataView extends GetView<PreRunViewDataController> {
  PreRunViewDataView({Key? key}) : super(key: key);

  final preRunViewDataController = Get.put(PreRunViewDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                onFieldSubmitted: (value){
                  controller.getPreRunDataRunNoWise(
                      runNo: controller.runNoController.text.isEmpty
                          ? 0
                          : int.parse(controller.runNoController.text));
                },
                controller: controller.runNoController,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                        onTap: () {

                          controller.getPreRunDataRunNoWise(
                              runNo: controller.runNoController.text.isEmpty
                                  ? 0
                                  : int.parse(controller.runNoController.text));
                        },
                        child: const Icon(
                          Icons.search,
                          size: 35,
                        )),
                    contentPadding: const EdgeInsets.only(left: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Enter Run No",
                    constraints: const BoxConstraints(maxHeight: 45)),
              ),
            ),
            Obx(
              () =>Expanded(
                      child: controller.isLoading.value == true
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
                                              child: Image.network(controller
                                                  .preRunDataList[index]
                                                  .image!),
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
