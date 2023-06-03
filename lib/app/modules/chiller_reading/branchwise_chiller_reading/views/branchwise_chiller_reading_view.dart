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
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Card(
                        child: ExpansionTile(
                          maintainState: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.amber,
                          onExpansionChanged: (value) {
                            if(value.toString() == "true") {
                              controller.fetchChillerCompressorReading(
                                  chillerReadingId: controller.chillerReadingDataList[index].readingId);
                            }
                            else{
                              controller.chillerCompressorDataList.value = [];
                            }
                          },
                          title: Column(
                            children: <Widget>[
                              MyTextWidget(
                                title: 'Branch Name',
                                body: controller
                                    .chillerReadingDataList[index]
                                    .branchName!,
                                isLines: false,
                              ),
                              MyTextWidget(
                                title: 'Phase Name',
                                body: controller
                                    .chillerReadingDataList[index]
                                    .phaseName!,
                                isLines: false,
                              ),
                            ],
                          ),
                          children: <Widget>[
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
                              title: 'Chiller Name',
                              body: controller
                                  .chillerReadingDataList[index]
                                  .chillerName,
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

                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Obx(() {
            return(controller.isCompressorLoading.value == true)?
            const Center(child: CircularProgressIndicator()):
            (controller.chillerCompressorDataList.isEmpty)?
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
              child: MyTextWidget(title: "Please Select a Card to View Compressor" , isLines: false),
            ):
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: controller.chillerCompressorDataList.length,
                  itemBuilder: (context, innerIndex) {
                    var status = "";
                    if (controller
                        .chillerCompressorDataList[innerIndex]
                        .status == 1) {
                      status = "ON";
                    }
                    else {
                      status = "OFF";
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
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
                      ),
                    );
                  }),
            );
          }),


        ],
      ),
    );
  }
}
