import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/pcc_reading/pcc_data/views/pcc_data_view.dart';

import '../../../../data/widgets.dart';
import '../controllers/insert_pcc_reading_controller.dart';

class InsertPccReadingView extends GetView<InsertPccReadingController> {
   InsertPccReadingView({Key? key}) : super(key: key);

  final insertPccReadingController = Get.put(InsertPccReadingController());
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(


      body: RefreshIndicator(
        onRefresh: () {
          return Future(() => controller.onInit());
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => (controller.pccNameList.isEmpty) ?
                      SizedBox(
                        width: w * 0.80,
                        child: const
                        Center(child: Text("Please Add at least 1 PCC"),),
                      ) :
                      TextFormWidget(
                        dropDownValue: controller.pccNameList[0].pccName,
                          dropDownWidth: w * 0.75,
                          dropDown: true,
                          titleText: 'Select PCC',
                          dropDownOnChanged: (value){
                          },
                          dropDownItems: controller.pccNameList.map((items) {
                            return DropdownMenuItem<String>(
                              onTap: () {
                                controller.selectedPccId.value = items.pccId!;
                              },
                              value: items.pccName,
                              child: Text(items.pccName!),
                            );
                          }).toList()
                      ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => PccDataView());
                          },
                        child:const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Icon(Icons.add_circle, size: 50, color: Colors.blue,),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Load(Amp.)-ACB';
                      }
                      return null;
                    },
                    controller:controller.aACB,
                    title: "Load(Amp.)-ACB",
                  ),

                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Load(Amp.)-MFM';
                      }
                      return null;
                    },
                    controller:controller.mMFM,
                    title: "Load(Amp.)-MFM",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Power Factor(MFM)';
                      }
                      return null;
                    },
                    controller:controller.pPowerFactorMFM,
                    title: "Power Factor(MFM)",
                  ),



                  const Text("All meter Status(PCC)",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  Obx(() => RadioListTile(
                    title:  const Text('ON'),
                    value: '1',
                    groupValue:controller.meter.value,
                    onChanged: (value) {
                      controller.meter(value.toString());
                    },
                  ),
                  ),

                  Obx(() => RadioListTile(
                    title:  const Text('OFF'),
                    value: '0',
                    groupValue:controller.meter.value,
                    onChanged: (value) {
                      controller.meter(value.toString());
                    },
                  ),
                  ),


                  const Text("All Light Status(PCC) ",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  Obx(() => RadioListTile(
                    title:  const Text('ON'),
                    value: '1',
                    groupValue:controller.light.value,
                    onChanged: (value) {
                      controller.light(value.toString());
                    },
                  ),
                  ),

                  Obx(() => RadioListTile(
                    title:  const Text('OFF'),
                    value: '0',
                    groupValue:controller.light.value,
                    onChanged: (value) {
                      controller.light(value.toString());
                    },
                  ),
                  ),


                  const Text("All Exhaust Fan Status ",
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  Obx(() => RadioListTile(
                    title:  const Text('ON'),
                    value: '1',
                    groupValue:controller.fan.value,
                    onChanged: (value) {
                      controller.fan(value.toString());
                    },
                  ),
                  ),

                  Obx(() => RadioListTile(
                    title:  const Text('OFF'),
                    value: '0',
                    groupValue:controller.fan.value,
                    onChanged: (value) {
                      controller.fan(value.toString());
                    },
                  ),
                  ),

                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter N-E (Volt)';
                      }
                      return null;
                    },
                    controller:controller.neVolt,
                    title: " N-E (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enterR-Y (Volt)';
                      }
                      return null;
                    },
                    controller:controller.ryVolt,
                    title: " R-Y (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Y-B (Volt)';
                      }
                      return null;
                    },
                    controller:controller.ybVolt,
                    title: " Y-B (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter B-R (Volt)';
                      }
                      return null;
                    },
                    controller:controller.brVolt,
                    title: " B-R (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter R-N (Volt)';
                      }
                      return null;
                    },
                    controller:controller.rnVolt,
                    title: " R-N (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Y-N (Volt)';
                      }
                      return null;
                    },
                    controller:controller.ynVolt,
                    title: " Y-N (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter B-N (Volt)';
                      }
                      return null;
                    },
                    controller:controller.bnVolt,
                    title: " B-N (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter R-E  (Volt)';
                      }
                      return null;
                    },
                    controller:controller.reVolt,
                    title: " R-E (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Y-E (Volt)';
                      }
                      return null;
                    },
                    controller:controller.yeVolt,
                    title: " Y-E (Volt) ",
                  ),


                  TextBoxWidget(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter B-E (Volt)';
                      }
                      return null;
                    },
                    controller:controller.beVolt,
                    title: " B-E (Volt) ",
                  ),


                  TextBoxWidget(
                    keyboardType: TextInputType.text,
                    controller:controller.remark,
                    title: " Remark ",
                  ),

                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                          fixedSize: Size(w, 20),
                        backgroundColor: Colors.orange),
                        onPressed: () {

                            if (controller.formKey.currentState!.validate()) {
                              controller.insertData();
                            }
                        },
                        child: const Text("Submit")),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}
