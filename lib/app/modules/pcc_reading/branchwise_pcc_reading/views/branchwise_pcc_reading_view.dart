import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../data/widgets.dart';
import '../controllers/branchwise_pcc_reading_controller.dart';

class BranchwisePccReadingView extends GetView<BranchwisePccReadingController> {
   BranchwisePccReadingView({Key? key}) : super(key: key);

  final branchwisePccReadingController = Get.put(BranchwisePccReadingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        return
          controller.isLoading.value == true ?
          const Center(child: CircularProgressIndicator()) :
          Column (
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                    child: IconButton(onPressed: (){
                      controller.convertToExcel(controller.jsonList);
                    }, icon: const Icon(Icons.download_rounded) , iconSize: 35 , color: Colors.blue,)),
              ),
              Obx(() => (controller.branchDataList.isEmpty) ?
              const Center(child: Text("No Branch Found"),) :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: TextFormWidget(
                    dropDownValue:controller.branchDataList[0]["branch_name"] ,
                    dropDown: true,
                    titleText: 'Branch',
                    dropDownOnChanged: (newValue){
                      // controller.selectedBranch(int.parse(newValue.toString()));
                    },
                    dropDownItems: controller.branchDataList.map((branch) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          controller.selectedBranchId.value = branch["branch_id"];
                          controller.selectedBranchName.value = branch["branch_name"];
                          controller.getPccData(branchId: controller.selectedBranchId.value);
                        },
                        value: branch["branch_name"],
                        child: Text(branch["branch_name"]),
                      );
                    }).toList()
                ),
              ),
              ),
              Expanded(
                child:  Obx(() {
                  return
                    controller.pccDataList.isEmpty
                        ?
                    Center(child: Lottie.asset('assets/lottie/no_data_found.json'),)
                        :
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.pccDataList.length,
                            itemBuilder: (context, index,) {
                                var meterStatus = "";
                              var lightStatus = "";
                              var fanStatus = "";

                              switch (controller.pccDataList[index].allMeterStatusPcc) {
                                case 0:
                                  meterStatus = "OFF";
                                  break;
                                case 1:
                                  meterStatus = "ON";
                                  break;
                                default :
                                  meterStatus = "OFF";
                              }
                              switch (controller.pccDataList[index].allLightStatusPcc) {
                                case 0:
                                  lightStatus = "OFF";
                                  break;
                                case 1:
                                  lightStatus = "ON";
                                  break;
                                default :
                                  lightStatus = "OFF";
                              }
                              switch (controller.pccDataList[index].allExhaustFanStatus) {
                                case 0:
                                  fanStatus = "OFF";
                                  break;
                                case 1:
                                  fanStatus = "ON";
                                  break;
                                default :
                                  fanStatus = "OFF";
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                child: Card(
                                  color: Colors.indigo.withRed(10),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10, right: 10, left: 10, bottom: 10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(icon: const Icon(Icons.edit, color: Colors.lightGreen),
                                              onPressed: () {
                                                updatePccData(context: context,
                                                  id: controller.pccDataList[index].pccDailyReadingId!,
                                                  branchIdFk: controller.pccDataList[index].branchIdFk!,
                                                  pccIdFk: controller.pccDataList[index].pccIdFk!,
                                                  loadAcb: controller.pccDataList[index].loadAmpAcb!,
                                                  loadMfm: controller.pccDataList[index].loadAmpMfm!,
                                                  powerMfm: controller.pccDataList[index].powerFactorMfm!,
                                                  meterStatus: controller.pccDataList[index].allMeterStatusPcc!,
                                                  lightStatus: controller.pccDataList[index].allLightStatusPcc!,
                                                  fanStatus: controller.pccDataList[index].allExhaustFanStatus!,
                                                  neVolt: controller.pccDataList[index].nEVolt!,
                                                  ryVolt: controller.pccDataList[index].rYVolt!,
                                                  ybVolt: controller.pccDataList[index].yBVolt!,
                                                  brVolt: controller.pccDataList[index].bRVolt!,
                                                  rnVolt: controller.pccDataList[index].rNVolt!,
                                                  ynVolt: controller.pccDataList[index].yNVolt!,
                                                  bnVolt: controller.pccDataList[index].bNVolt!,
                                                  reVolt: controller.pccDataList[index].rEVolt!,
                                                  yeVolt: controller.pccDataList[index].yEVolt!,
                                                  beVolt: controller.pccDataList[index].bEVolt!,
                                                  reMark: controller.pccDataList[index].remarkIfAny!,
                                                );
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              onPressed: () {
                                                deletePccData(context: context,
                                                  id: controller.pccDataList[index].pccDailyReadingId!,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        MyTextWidget(title: "Date : " , body: controller.pccDataList[index].pccDailyReadingCreatedOn,),
                                        MyTextWidget(title: "Branch : " , body: controller.pccDataList[index].branchName,),
                                        MyTextWidget(title: "PCC Name : " , body: controller.pccDataList[index].pccName,),
                                        MyTextWidget(title: "Load(Amp.)-ACB : " , body: controller.pccDataList[index].loadAmpAcb,),
                                        MyTextWidget(title: "Load(Amp.)-MFM : " , body: controller.pccDataList[index].loadAmpMfm,),
                                        MyTextWidget(title: "Power Factor - MFM : " , body: controller.pccDataList[index].powerFactorMfm,),
                                        MyTextWidget(title: "All Meter Status(PCC) :" , body: meterStatus,),
                                        MyTextWidget(title: "All Light Status(PCC) :" , body: lightStatus,),
                                        MyTextWidget(title: "All Exhaust Fan Status(PCC) :" , body: fanStatus,),
                                        MyTextWidget(title: "N-E(Volt) : " , body: controller.pccDataList[index].nEVolt,),
                                        MyTextWidget(title: "R-Y(Volt) : " , body: controller.pccDataList[index].rYVolt,),
                                        MyTextWidget(title: "Y-B(Volt) : " , body: controller.pccDataList[index].yBVolt,),
                                        MyTextWidget(title: "B-R(Volt) : " , body: controller.pccDataList[index].bRVolt,),
                                        MyTextWidget(title: "R-N(Volt) : " , body: controller.pccDataList[index].rNVolt,),
                                        MyTextWidget(title: "Y-N(Volt) : " , body: controller.pccDataList[index].yNVolt,),
                                        MyTextWidget(title: "B-N(Volt) : " , body: controller.pccDataList[index].bNVolt,),
                                        MyTextWidget(title: "R-E(Volt) : " , body: controller.pccDataList[index].rEVolt,),
                                        MyTextWidget(title: "Y-E(Volt) : " , body: controller.pccDataList[index].yEVolt,),
                                        MyTextWidget(title: "Remarks : " , body: controller.pccDataList[index].remarkIfAny,),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                },
                ),
              ),
            ],
          );

      },

      ),

    );
  }



//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____


  void updatePccData({required BuildContext context,
        required int id,
        required int branchIdFk,
        required int pccIdFk,
        required String loadAcb,
        required String loadMfm,
        required String powerMfm,
        required int meterStatus,
        required int lightStatus,
        required int fanStatus,
        required String neVolt,
        required String ryVolt,
        required String ybVolt,
        required String brVolt,
        required String rnVolt,
        required String ynVolt,
        required String bnVolt,
        required String reVolt,
        required String yeVolt,
        required String beVolt,
        required String reMark,})
  {controller.aACB.text = loadAcb;
    controller.mMFM.text = loadMfm;
    controller.pPowerFactorMFM.text = powerMfm;
    controller.neVolt.text = neVolt;
    controller.ryVolt.text = ryVolt;
    controller.ybVolt.text = ybVolt;
    controller.brVolt.text = brVolt;
    controller.rnVolt.text = rnVolt;
    controller.ynVolt.text = ynVolt;
    controller.bnVolt.text = bnVolt;
    controller.reVolt.text = reVolt;
    controller.yeVolt.text = yeVolt;
    controller.beVolt.text = beVolt;
    controller.remark.text = reMark;
    controller.meter.value = meterStatus.toString();
    controller.light.value = lightStatus.toString();
    controller.fan.value = fanStatus.toString();

    showBottomSheet(context: context, builder: (context){

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.aACB,
                  title: "Load(Amp.)-ACB ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.mMFM,
                  title: "Load(Amp.)-MFM",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.pPowerFactorMFM,
                  title: "Power Factor(MFM)",
                ),
                const Text("All meter Status(PCC)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),

                Obx(() =>
                    RadioListTile(
                      title: const Text('ON'),
                      value: '1',
                      groupValue: controller.meter.value,
                      onChanged: (value) {
                        controller.meter(value.toString());
                      },
                    ),
                ),

                Obx(() =>
                    RadioListTile(
                      title: const Text('OFF'),
                      value: '0',
                      groupValue: controller.meter.value,
                      onChanged: (value) {
                        controller.meter(value.toString());

                      },
                    ),
                ),

                const SizedBox(height: 15),
                const Text("All Light Status(PCC) ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

                Obx(() =>
                    RadioListTile(
                      title: const Text('ON'),
                      value: '1',
                      groupValue: controller.light.value,
                      onChanged: (value) {
                        controller.light(value.toString());

                      },
                    ),
                ),

                Obx(() =>
                    RadioListTile(
                      title: const Text('OFF'),
                      value: '0',
                      groupValue: controller.light.value,
                      onChanged: (value) {
                        controller.light(value.toString());
                        // controller.lightStatus.value = value.toString();
                      },
                    ),
                ),

                const SizedBox(height: 15),
                const Text("All Exhaust Fan Status ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),

                Obx(() =>
                    RadioListTile(
                      title: const Text('ON'),
                      value: '1',
                      groupValue: controller.fan.value,
                      onChanged: (value) {
                        controller.fan(value.toString());

                      },
                    ),
                ),

                Obx(() =>
                    RadioListTile(
                      title: const Text('OFF'),
                      value: '0',
                      groupValue: controller.fan.value,
                      onChanged: (value) {
                        controller.fan(value.toString());

                      },
                    ),
                ),
                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.neVolt,
                  title: " N-E (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.ryVolt,
                  title: " R-Y (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.ybVolt,
                  title: " Y-B (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.brVolt,
                  title: " B-R (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.rnVolt,
                  title: " R-N (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.ynVolt,
                  title: " Y-N (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.bnVolt,
                  title: " B-N (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.reVolt,
                  title: " R-E (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.yeVolt,
                  title: " Y-E (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.beVolt,
                  title: " B-E (Volt) ",
                ),

                const SizedBox(height: 15),
                TextBoxWidget(
                  controller: controller.remark,
                  title: " Remark ",
                ),

                ElevatedButton(onPressed: () {
                  controller.updatePccData(
                    id: id,
                    branchIdFk: branchIdFk,
                    pccIdFk: pccIdFk,
                  );
                },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.8, 10)
                  ),
                  child: const Text("Submit"),),
              ],
            ),
          ),
        ),
      );
    });
  }



//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________


  void deletePccData({required BuildContext context, required int id,})
  {
    AlertDialog alertDialog = AlertDialog(
        actions: [
          ElevatedButton(onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("NO"),),

          ElevatedButton(onPressed: () {
            controller.deletePccData(id:id);
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("YES"),),

        ],

        content: Text("Are You Sure Want to Delete $id ")
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
