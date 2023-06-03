import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/ups_reading/upsData/views/ups_data_view.dart';
import '../../../data/constants.dart';
import '../../../data/widgets.dart';
import '../../employee_management/branch_data/views/branch_data_view.dart';
import '../controllers/ups_reading_controller.dart';

class UpsReadingView extends GetView<UpsReadingController> {
  UpsReadingView({Key? key}) : super(key: key);
  final upsReadingController = Get.put(UpsReadingController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPS Monitoring/ Reading Form'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () {
            return Future(() => controller.onInit());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(()=>
            (controller.isLoading.value == true)?Container(alignment: Alignment.center,height: h,  child: const CircularProgressIndicator()):
               Form(
                 key: controller.formKey,
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => (controller.branchDataList.isEmpty)
                            ? SizedBox(
                                width: (privilage.value == "Admin" ||
                                        privilage.value == "Editor")
                                    ? w / 1.5
                                    : w / 1.2,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ))
                            : TextFormWidget(
                          dropDownValue: controller.branchDataList[0]["branch_name"],
                                dropDownWidth: (privilage.value == "Admin" ||
                                        privilage.value == "Editor")
                                    ? w / 1.5
                                    : w / 1.2,
                                dropDown: true,
                                titleText: "Branch",
                                dropDownOnChanged: (newValue) {
                                  controller.selectedBranch(newValue.toString());
                                },
                                dropDownItems:
                                    controller.branchDataList.map((branch) {
                                  return DropdownMenuItem<String>(
                                    onTap: () {
                                      controller.selectedBranchId.value =
                                          branch['branch_id'];
                                      controller.selectedBranchId.value = controller.selectedBranchId.value;
                                    },
                                    value: branch['branch_name'],
                                    child: Text(branch['branch_name']),
                                  );
                                }).toList())),
                        Obx(
                          () => (privilage.value == "Admin" ||
                                  privilage.value == "Editor")
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => BranchDataView());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                  ))
                              : Container(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => (controller.upsDataList.isEmpty)
                            ? SizedBox(
                                width: (privilage.value == "Admin" ||
                                        privilage.value == "Editor")
                                    ? w / 1.5
                                    : w / 1.2,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ))
                            : TextFormWidget(
                                dropDownWidth: (privilage.value == "Admin" ||
                                        privilage.value == "Editor")
                                    ? w / 1.5
                                    : w / 1.2,
                                dropDown: true,
                                titleText: "Ups",
                                dropDownOnChanged: (newValue) {
                                  // controller.selectedBranch(newValue.toString());
                                },
                                dropDownItems: controller.upsDataList.map((ups) {
                                  return DropdownMenuItem<String>(
                                    onTap: () {
                                      controller.selectedUpsId.value = ups.upsId!;
                                    },
                                    value: ups.upsName,
                                    child: Text(ups.upsName!),
                                  );
                                }).toList())),
                        Obx(
                          () => (privilage.value == "Admin" ||
                                  privilage.value == "Editor")
                              ? InkWell(
                                  onTap: () {
                                    Get.to(() => UpsDataView());
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Icon(
                                      Icons.add_circle,
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                  ))
                              : Container(),
                        ),
                      ],
                    ),
                    TextBoxWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Load On Ups R";
                        }
                        return null;
                      },
                      title: "Load On Ups R",
                      controller: controller.loadOnUpsRController,
                    ),
                    TextBoxWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Load On Ups Y";
                        }
                        return null;
                      },
                      title: "Load On Ups Y",
                      controller: controller.loadOnUpsYController,
                    ),
                    TextBoxWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Load On Ups B";
                        }
                        return null;
                      },
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
                      () => MyRadioList(
                        title: 'Red',
                        value: '1',
                        activeColor: Colors.red,
                        groupValue: controller.ledStatus.value,
                        onChanged: (value) {
                          controller.ledStatus.value = value.toString();
                        },
                      ),
                    ),
                    Obx(
                      () => MyRadioList(
                        activeColor: Colors.green,
                        title: 'Green',
                        value: '2',
                        groupValue: controller.ledStatus.value,
                        onChanged: (value) {
                          controller.ledStatus.value = value.toString();
                        },
                      ),
                    ),
                    Obx(
                      () => MyRadioList(
                        activeColor: Colors.orange,
                        title: 'Orange',
                        value: '3',
                        groupValue: controller.ledStatus.value,
                        onChanged: (value) {
                          controller.ledStatus.value = value.toString();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextBoxWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter DC Positive Voltage";
                        }
                        return null;
                      },
                      title: "DC Positive Voltage",
                      controller: controller.positiveVoltageController,
                    ),
                    TextBoxWidget(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter DC Negative Voltage";
                        }
                        return null;
                      },
                      title: "DC Negative Voltage",
                      controller: controller.negativeVoltageController,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(fixedSize: Size(w / 2.5,
                                10), backgroundColor: Colors.orange),
                            onPressed: (){

                          if (controller.formKey.currentState!.validate()) {
                            if(controller.selectedBranchId.value == 0){
                              showToastError(msg: "Please Select Branch");
                            }
                            else if(controller.selectedUpsId.value == 0){
                              showToastError(msg: "Please Select Ups");
                            }
                            else if(controller.ledStatus.value == ""){
                              showToastError(msg: "Please Select Led Status");
                            }
                            else {
                              controller.addUpsReading();
                            }
                          }

                          }, child: const Text("Submit")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                fixedSize: Size(w / 2.5, 10)),
                            onPressed: ()=>Get.to(() => const UpsReadingTabBar()), child: const Text("View")),
                      ],
                    )
                  ],
              ),
               ),
            ),
          ),
        ),
      ),
    );
  }
}
