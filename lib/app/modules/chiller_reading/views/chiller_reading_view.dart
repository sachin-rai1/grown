import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/chiller_compressor/views/chiller_compressor_view.dart';
import 'package:grown/app/modules/chiller_reading/chiller_phase/views/chiller_phase_view.dart';
import 'package:grown/app/modules/chiller_reading/chillers/views/chillers_view.dart';
import 'package:grown/app/modules/chiller_reading/process_pump/views/process_pump_view.dart';
import '../../../data/constants.dart';
import '../../../data/widgets.dart';
import '../controllers/chiller_reading_controller.dart';

class ChillerReadingView extends GetView<ChillerReadingController> {
  ChillerReadingView({Key? key}) : super(key: key);
  final chillerReadingController = Get.put(ChillerReadingController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chiller Daily Reading'),
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
            child: Obx(() {
              return (controller.isUpload.value == true)
                  ? Container(
                      alignment: Alignment.center,
                      height: h,
                      child: const CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => (controller.isLoading.value == true)
                                ? SizedBox(
                                    width: (privilage.value == "Admin" ||
                                            privilage.value == "Editor")
                                        ? w / 1.5
                                        : w / 1.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ))
                                : (controller.phaseDataList.isEmpty)
                                    ? SizedBox(
                                        width: (privilage.value == "Admin" ||
                                                privilage.value == "Editor")
                                            ? w / 1.5
                                            : w / 1.2,
                                        child: const Center(
                                          child: Text(
                                            "No Phase Found for selected branch",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ))
                                    : TextFormWidget(
                                        dropDownValue: controller
                                            .phaseDataList[0].phaseName,
                                        dropDownWidth:
                                            (privilage.value == "Admin" ||
                                                    privilage.value == "Editor")
                                                ? w / 1.5
                                                : w / 1.2,
                                        dropDown: true,
                                        titleText: "Phase",
                                        dropDownOnChanged: (newValue) {
                                          controller.selectedPhase(
                                              newValue.toString());
                                          controller.clearData();
                                        },
                                        dropDownItems: controller.phaseDataList
                                            .map((phase) {
                                          return DropdownMenuItem<String>(
                                            onTap: () async {
                                              controller.selectedPhaseId.value = phase.phaseId!;

                                              if (controller.phaseDataList.isEmpty) {
                                                controller.chillerDataList.value = [];
                                              } else {
                                                await controller.fetchChiller(phaseId: phase.phaseId!);
                                                await controller.fetchProcessPump(phaseId: phase.phaseId!);
                                              }

                                              if (controller.chillerDataList.isEmpty)
                                              {
                                                controller.compressorDataList.value = [];

                                              } else
                                              {
                                                  await controller.fetchCompressor(chillerId: controller.chillerDataList[0].chillerId!);
                                                  controller.selectedChillerId.value = controller.chillerDataList[0].chillerId!;
                                              }
                                            },
                                            value: phase.phaseName,
                                            child: Text(phase.phaseName!),
                                          );
                                        }).toList())),
                            Obx(
                              () => (privilage.value == "Admin" ||
                                      privilage.value == "Editor")
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(() => ChillerPhaseView());
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
                          title: "Inlet Temperature",
                          controller: controller.inletTemperatureController,
                        ),
                        TextBoxWidget(
                          title: "Outlet Temperature",
                          controller: controller.outletTemperatureController,
                        ),
                        TextBoxWidget(
                          title: "Process Pump Pressure (Bar)",
                          controller: controller.processPumpPressureController,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right:  8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             const Text('Circulation Pump 1 : ' , style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Radio(
                                  value: '1',
                                  groupValue: controller.circulationPumpStatus1.value,
                                  onChanged: (value) {controller.updatePumpStatus1(value.toString());
                                  },
                                ),
                                const Text('On' , style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),),
                                Radio(
                                  value: '0',
                                  groupValue:
                                      controller.circulationPumpStatus1.value,
                                  onChanged: (value) {
                                    controller.updatePumpStatus1(value.toString());
                                  },
                                ),
                                const Text('Off' , style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),),
                              ],
                            ),
              ]
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:  8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             const Text('Circulation Pump 2 : ' , style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Radio(
                                  value: '1',
                                  groupValue: controller.circulationPumpStatus2.value,
                                  onChanged: (value) {
                                    controller.updatePumpStatus2(value.toString());
                                  },
                                ),
                                const Text('On', style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),),
                                Radio(
                                  value: '0',
                                  groupValue: controller.circulationPumpStatus2.value,
                                  onChanged: (value) {
                                    controller.updatePumpStatus2(value.toString());

                                  },
                                ),
                                const Text('Off' , style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),),
                              ],
                            ),
                            ]
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Process Pump",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Obx(
                                  () => (privilage.value == "Admin" ||
                                  privilage.value == "Editor")
                                  ? InkWell(
                                  onTap: () {
                                    Get.to(() => ProcessPumpView());
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
                        Obx(() {
                          return (controller.isProcessPumpLoading.value == true)
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.processPumpDataList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.processPumpDataList[index].processPumpName!} :",
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                              () => MyRadioList(
                                            width: 100,
                                            title: 'ON',
                                            value: '1',
                                            groupValue: controller.processPumpStatus[index],
                                            onChanged: (value) {
                                              controller.processPumpStatus[index] = value.toString();
                                              controller.getProcessPumpStatus();
                                              // controller.insertDataToAPI(readingId: 1);
                                            },
                                          ),
                                        ),
                                        Obx(
                                              () => MyRadioList(
                                            width: 100,
                                            title: 'OFF',
                                            value: '0',
                                            groupValue: controller.processPumpStatus[index],
                                            onChanged: (value) {
                                              controller.processPumpStatus[index] = value.toString();
                                              controller.getProcessPumpStatus();

                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        }),




                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() => (controller.isChillerLoading.value == true)
                                ? SizedBox(
                                    width: (privilage.value == "Admin" || privilage.value == "Editor") ? w / 1.5 : w / 1.2,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ))
                                : (controller.chillerDataList.isEmpty)
                                    ? SizedBox(
                                        width: (privilage.value == "Admin" || privilage.value == "Editor") ? w / 1.5 : w / 1.2,
                                        child: const Center(
                                          child: Text(
                                            "No Chiller Found for selected Phase",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ))
                                    : TextFormWidget(
                                        dropDownValue: controller.chillerDataList[0].chillerName,
                                        dropDownHeight: 40,
                                        dropDownWidth: (privilage.value == "Admin" || privilage.value == "Editor") ? w / 1.5 : w / 1.2,
                                        dropDown: true,
                                        titleText: "Chiller",
                                        dropDownOnChanged: (newValue) {
                                          controller.selectedChiller(
                                              newValue.toString());
                                        },
                                        dropDownItems: controller
                                            .chillerDataList
                                            .map((chiller) {
                                          return DropdownMenuItem<String>(
                                            onTap: () async {
                                              controller.selectedChillerId
                                                  .value = chiller.chillerId!;
                                              await controller.fetchCompressor(
                                                  chillerId: controller
                                                      .selectedChillerId.value);
                                              await controller.getCompressorStatus();
                                            },
                                            value: chiller.chillerName,
                                            child: Text(chiller.chillerName!),
                                          );
                                        }).toList())),
                            Obx(
                              () => (privilage.value == "Admin" ||
                                      privilage.value == "Editor")
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(() => ChillersView());
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
                          title: "Average Load",
                          controller: controller.averageLoadController,
                          height: 0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Text(
                                "Compressors",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Obx(
                              () => (privilage.value == "Admin" ||
                                      privilage.value == "Editor")
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(() => ChillerCompressorView());
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

                        Obx(() {
                          return (controller.isCompressorLoading.value == true)
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                              controller.compressorDataList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${controller.compressorDataList[index].compressorName!} :",
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                              () => MyRadioList(
                                            width: 100,
                                            title: 'ON',
                                            value: '1',
                                            groupValue: controller.compressorStatus[index],
                                            onChanged: (value) {
                                              controller.compressorStatus[index] = value.toString();
                                              controller.getCompressorStatus();
                                              // controller.insertDataToAPI(readingId: 1);
                                            },
                                          ),
                                        ),
                                        Obx(
                                              () => MyRadioList(
                                            width: 100,
                                            title: 'OFF',
                                            value: '0',
                                            groupValue: controller.compressorStatus[index],
                                            onChanged: (value) {
                                              controller.compressorStatus[index] = value.toString();
                                              controller.getCompressorStatus();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        }),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(w / 2.5, 10),
                                    backgroundColor: Colors.orange),
                                onPressed: () {
                                  controller.addChillerReadingData();
                                },
                                child: const Text("Submit")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    fixedSize: Size(w / 2.5, 10)),
                                onPressed: () {
                                  Get.to(() => const ChillerReadingTabBar());
                                },
                                child: const Text("View"))
                          ],
                        )
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
