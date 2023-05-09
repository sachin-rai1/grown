import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/run_no_data_controller.dart';

class RunNoDataView extends GetView<RunNoDataController> {
   RunNoDataView({Key? key}) : super(key: key);
  final runNoDataController = Get.put(RunNoDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RunNoDataView'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            addRunData(context);
          }, icon: const Icon(Icons.add_circle) , iconSize: 45,)
        ],
      ),
      body: Obx(()=>
      (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),):
         ListView.builder(
           physics: const BouncingScrollPhysics(),
           itemCount: controller.runNoDataList.length,
             itemBuilder: (context , index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
            child: Card(
              color: Colors.redAccent.shade100,
              child: Column(
                children:  [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        InkWell(onTap: (){
                          updateRunData(
                              context: context,
                              runId:controller.runNoDataList[index].runId!,
                              runNo:controller.runNoDataList[index].runNo!,
                              holderSize: controller.runNoDataList[index].holderSize!,
                              totalPcsNo: controller.runNoDataList[index].totalPcsNo!,
                              totalPcsArea: controller.runNoDataList[index].totalPcsArea!,
                              bigPcsNo: controller.runNoDataList[index].bigPcsNo!,
                              regularPcsNo: controller.runNoDataList[index].regularPcsNo!,
                          );
                        }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                        const SizedBox(width: 20,),
                        InkWell(onTap: (){
                          deleteRunData(context: context, runId: controller.runNoDataList[index].runId!);
                        }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                      ],
                    ),
                  ),
                  MyTextWidget(title: "Run id" ,body: controller.runNoDataList[index].runId.toString()),
                  MyTextWidget(title: "Run No" , body:controller.runNoDataList[index].runNo.toString()),
                  MyTextWidget(title: "Holder Size" , body:controller.runNoDataList[index].holderSize.toString()),
                  MyTextWidget(title: "Total Pcs No: " , body:controller.runNoDataList[index].totalPcsNo.toString()),
                  MyTextWidget(title: "Total Pcs Area : " , body:controller.runNoDataList[index].totalPcsArea.toString()),
                  MyTextWidget(title: "Big Pcs No : " , body:controller.runNoDataList[index].bigPcsNo.toString()),
                  MyTextWidget(title: "Regular Pcs No :"  , body:controller.runNoDataList[index].regularPcsNo.toString()),
                ],
              ),
            ),
          );
        }),
      )
    );
  }

  void addRunData(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    AlertDialog alertDialog = AlertDialog(
      content:(controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),): Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              MlgdTextFormWidget(
                controller: controller.runNoController,
                title: "Run No.",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter run No';
                  }
                  return null;
                },
              ),
              const Text("Holder Size"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "F :  ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(()=>
                     MyRadioList(
                      width: width / 4,
                      title: '3"',
                      value: '3"F',
                      groupValue: controller.size.value,
                      onChanged: (value) {
                        controller.size.value = value.toString();
                      },
                    ),
                  ),
                  Obx(()=>
                     MyRadioList(
                      width: width / 4,
                      title: '3.5"',
                      value: '3.5"F',
                      groupValue: controller.size.value,
                      onChanged: (value) {
                        controller.size.value = value.toString();
                      },
                    ),
                  ),

                ],
              ),
              Obx(()=>
                 MyRadioList(
                  width: width / 4,
                  title: '4.25"',
                  value: '4.25"F',
                  groupValue: controller.size.value,
                  onChanged: (value) {
                    controller.size.value = value.toString();
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "D : ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Obx(()=>
                     MyRadioList(
                      width: width / 4,
                      title: '3"',
                      value: '3"D',
                      groupValue: controller.size.value,
                      onChanged: (value) {
                        controller.size.value = value.toString();
                      },
                    ),
                  ),
                  Obx(()=>
                     MyRadioList(
                      width: width / 4,
                      title: '3.5"',
                      value: '3.5"D',
                      groupValue: controller.size.value,
                      onChanged: (value) {
                        controller.size.value = value.toString();
                      },
                    ),
                  ),
                ],
              ),
              Obx(()=>
                 MyRadioList(
                  width: width / 4,
                  title: '4.25" ',
                  value: '4.25"D',
                  groupValue: controller.size.value,
                  onChanged: (value) {
                    controller.size.value = value.toString();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MlgdTextFormWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Total Pcs No';
                  }
                  return null;
                },
                controller: controller.totalPcsNoController,
                title: "Total Pcs No.",
              ),
              MlgdTextFormWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Total Pcs Area (in Sq. mm)';
                    }
                    return null;
                  },
                  controller: controller.totalPcsAreaController,
                  title: "Total Pcs Area (in Sq. mm)"),
              MlgdTextFormWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Big Pcs No.';
                    }
                    return null;
                  },
                  controller: controller.bigPcsNoController,
                  title: "Big Pcs No."),
              MlgdTextFormWidget(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Regular Pcs Number';
                    }
                    return null;
                  },
                  controller: controller.regularPcsNumberController,
                  title: "Regular Pcs Number"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!
                            .validate()) {
                          controller.addRunNoData();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.6, 15),
                          backgroundColor: Colors.purple.shade600,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(context: context, builder: (context){return alertDialog; });
  }
  void updateRunData({required BuildContext context,
     required int runId,
     required int runNo,
    required String  holderSize,
    required int  totalPcsNo,
    required int  totalPcsArea,
    required int  bigPcsNo,
    required int  regularPcsNo,
   }) {

    controller.updateRunNoController.text = runNo.toString();
    controller.updateSize.value = holderSize.toString();
    controller.updateTotalPcsNoController.text = totalPcsNo.toString();
    controller.updateTotalPcsAreaController.text = totalPcsArea.toString();
    controller.updateBigPcsNoController.text = bigPcsNo.toString();
    controller.updateRegularPcsNumberController.text = regularPcsNo.toString();

     var width = MediaQuery.of(context).size.width;
     AlertDialog alertDialog = AlertDialog(
       content:(controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),): Form(
         key: controller.formKey,
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               MlgdTextFormWidget(
                 readOnly: true,
                 controller: controller.updateRunNoController,
                 title: "Run No.",
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter run No';
                   }
                   return null;
                 },
               ),

               const Text("Holder Size"),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const Text(
                     "F :  ",
                     style: TextStyle(fontSize: 16),
                   ),
                   Obx(()=>
                       MyRadioList(
                         width: width / 4,
                         title: '3"',
                         value: '3"F',
                         groupValue: controller.updateSize.value,
                         onChanged: (value) {
                           controller.updateSize.value = value.toString();
                         },
                       ),
                   ),
                   Obx(()=>
                       MyRadioList(
                         width: width / 4,
                         title: '3.5"',
                         value: '3.5"F',
                         groupValue: controller.updateSize.value,
                         onChanged: (value) {
                           controller.updateSize.value = value.toString();
                         },
                       ),
                   ),

                 ],
               ),
               Obx(()=>
                   MyRadioList(
                     width: width / 4,
                     title: '4.25"',
                     value: '4.25"F',
                     groupValue: controller.updateSize.value,
                     onChanged: (value) {
                       controller.updateSize.value = value.toString();
                     },
                   ),
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   const Text(
                     "D : ",
                     style: TextStyle(fontSize: 16),
                   ),
                   Obx(()=>
                       MyRadioList(
                         width: width / 4,
                         title: '3"',
                         value: '3"D',
                         groupValue: controller.updateSize.value,
                         onChanged: (value) {
                           controller.updateSize.value = value.toString();
                         },
                       ),
                   ),
                   Obx(()=>
                       MyRadioList(
                         width: width / 4,
                         title: '3.5"',
                         value: '3.5"D',
                         groupValue: controller.updateSize.value,
                         onChanged: (value) {
                           controller.updateSize.value = value.toString();
                         },
                       ),
                   ),
                 ],
               ),
               Obx(()=>
                   MyRadioList(
                     width: width / 4,
                     title: '4.25" ',
                     value: '4.25"D',
                     groupValue: controller.updateSize.value,
                     onChanged: (value) {
                       controller.updateSize.value = value.toString();
                     },
                   ),
               ),
               const SizedBox(
                 height: 20,
               ),
               MlgdTextFormWidget(
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Total Pcs No';
                   }
                   return null;
                 },
                 controller: controller.updateTotalPcsNoController,
                 title: "Total Pcs No.",
               ),
               MlgdTextFormWidget(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter Total Pcs Area (in Sq. mm)';
                     }
                     return null;
                   },
                   controller: controller.updateTotalPcsAreaController,
                   title: "Total Pcs Area (in Sq. mm)"),
               MlgdTextFormWidget(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter Big Pcs No.';
                     }
                     return null;
                   },
                   controller: controller.updateBigPcsNoController,
                   title: "Big Pcs No."),
               MlgdTextFormWidget(
                   validator: (value) {
                     if (value == null || value.isEmpty) {
                       return 'Please enter Regular Pcs Number';
                     }
                     return null;
                   },
                   controller: controller.updateRegularPcsNumberController,
                   title: "Regular Pcs Number"),
               const SizedBox(
                 height: 20,
               ),
               Padding(
                 padding: const EdgeInsets.all(10),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     ElevatedButton(
                       onPressed: () {
                         if (controller.formKey.currentState!
                             .validate()) {
                           controller.updateRunNo(runId: runId);
                         }
                       },
                       style: ElevatedButton.styleFrom(
                           fixedSize: Size(width * 0.6, 15),
                           backgroundColor: Colors.purple.shade600,
                           shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(10))),
                       child: const Text("Submit"),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       ),
     );
     showDialog(context: context, builder: (context){return alertDialog; });
   }

   void deleteRunData({required BuildContext context , required int runId}){
     AlertDialog alertDialog =  AlertDialog(
       actions: [
         ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
         ElevatedButton(onPressed: ()=>controller.deleteRunNo(runId: runId), child: const Text("Submit")),
       ],
       content: const Text("Are You Sure Want to Delete ?"),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });
   }



}
