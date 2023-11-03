import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../../data/constants.dart';
import '../../../../../data/widgets.dart';
import '../controllers/view_mlgd_data_date_wise_controller.dart';

class ViewMlgdDataDateWiseView extends GetView<ViewMlgdDataDateWiseController> {
   ViewMlgdDataDateWiseView({Key? key}) : super(key: key);
  final viewMlgdDataDateWiseController =  Get.put(ViewMlgdDataDateWiseController());
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                     controller.fetchMlgdData(controller.formatted);

                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => log(val.toString()),
                  ),
                ),
                InkWell(onTap: (){
                  convertToExcel(jsonList: controller.jsonList,fileName: "DateWiseRunningData");
                }, child: const Icon(Icons.download_for_offline , size: 45, color: Colors.blue,)),
              ],
            ),
          ),
          Obx(
                () =>(controller.isLoading.value == true)?const Center(child: CircularProgressIndicator()): (controller.mlgdDataList.isEmpty == true)
                ?  Center(
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/1.5,
                    child: const Text("No Data Found" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),)))
                : Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                  itemCount: controller.mlgdDataList.length,
                  itemBuilder: (BuildContext context, index) {
                    dynamic cleanPer = controller.mlgdDataList[index].cleanPcsNo! / controller.mlgdDataList[index].totalPcsNo! * 100;
                    var topView = controller.mlgdDataList[index].topView;
                    print(topView);
                    var frontView = controller.mlgdDataList[index].frontView;
                    print(frontView);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Card(
                        color: Colors.pink.shade50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children:  [
                                    InkWell(onTap: (){
                                      updateMlgdData(context: context,
                                          mlgdId: controller.mlgdDataList[index].mlgdId!,
                                          b: controller.mlgdDataList[index].breakagePcs!,
                                          c: controller.mlgdDataList[index].cleanPcsNo!,
                                          d: controller.mlgdDataList[index].dotPcs!,
                                          i: controller.mlgdDataList[index].inclusionPcs!,
                                          x: controller.mlgdDataList[index].x!,
                                          y: controller.mlgdDataList[index].y!,
                                          z: controller.mlgdDataList[index].z!,
                                          t: controller.mlgdDataList[index].t!
                                      );
                                    }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                                    const SizedBox(width: 20,),
                                    InkWell(onTap: (){
                                      deleteMlgdData(context: context, mlgdId: controller.mlgdDataList[index].mlgdId!,);
                                    }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                                    const SizedBox(width: 20,),

                                  ],
                                ),
                              ),
                              MyTextWidget(
                                title: "Date : " , body: controller.mlgdDataList[index].createdOn.toString(),
                              ),
                              Container(
                                  width:
                                  MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.5)),
                              MyTextWidget(title: "Run No : " , body: controller.mlgdDataList[index].runNo.toString(),),
                              MyTextWidget(title: "Clean % : " , body: " ${num.parse(cleanPer.toString()).toStringAsFixed(2)} %",),
                              MyTextWidget(title: "Holder Size : " , body: controller.mlgdDataList[index].holderSize.toString(),),
                              MyTextWidget(title: "Running Hours : " , body: controller.mlgdDataList[index].runningHours.toString(),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyTextWidget(isLines: false, title: "X : " , body: controller.mlgdDataList[index].x.toString(),),
                                  MyTextWidget(isLines: false, title: "Y : " , body: controller.mlgdDataList[index].y.toString(),),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyTextWidget(isLines: false, title: "Z : " , body: controller.mlgdDataList[index].z.toString(),),
                                  MyTextWidget(isLines: false, title: "T : " , body: controller.mlgdDataList[index].t.toString(),),
                                ],
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.only(bottom: 10),
                                child: Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.5)),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text("Front View "),
                                      GestureDetector(
                                        onTap: (){
                                          showBottomSheet(context: context,
                                              builder: (context) {
                                                return PhotoView(
                                                  imageProvider: NetworkImage(frontView),);
                                              });

                                        },
                                        child: Image.network(
                                          frontView!,
                                          height: 100,
                                          width: 100,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Text("Top View"),
                                      GestureDetector(
                                        onTap: (){
                                          showBottomSheet(context: context,
                                              builder: (context) {
                                                return PhotoView(
                                                  imageProvider: NetworkImage(topView),);
                                              });

                                        },
                                        child: Image.network(
                                          topView!,
                                          height: 100,
                                          width: 100,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
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
  void enlargeImage(data , BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Image.network(data),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
   void updateMlgdData({required BuildContext context ,required int mlgdId, required int b , required int c ,required int d ,required int i ,required int x ,required int y ,required int z ,required int t}){

     controller.cleanPcsController.text = c.toString();
     controller.breakagePcsController.text =b.toString();
     controller.dotPcsController.text = d.toString();
     controller.inclusionPcsController.text =i.toString();
     controller.xController.text = x.toString();
     controller.yController.text = y.toString();
     controller.zController.text = z.toString();
     controller.tController.text = t.toString();

     AlertDialog alertDialog = AlertDialog(
       actions: [
         ElevatedButton(
           onPressed: ()=>Get.back(),
           style: ElevatedButton.styleFrom(

               backgroundColor: Colors.redAccent,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10))),
           child: const Text("Cancel"),
         ),
         ElevatedButton(
           onPressed: () {
             if (controller.formKey.currentState!
                 .validate()) {
               controller.updateMlgdData(mlgdId: mlgdId);
             }
           },
           style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green.shade600,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10))),
           child: const Text("Submit"),
         ),

       ],
       content: Form(
         key: controller.formKey,
         child: SingleChildScrollView(
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children:  [
               MlgdTextFormWidget(
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Clean Pcs';
                   }
                   return null;
                 },
                 controller: controller.cleanPcsController,
                 title: "Clean Pcs",
               ),
               MlgdTextFormWidget(
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Breakage Pcs';
                   }
                   return null;
                 },
                 controller: controller.breakagePcsController,
                 title: "Breakage Pcs",
               ),
               MlgdTextFormWidget(
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Dot Pcs';
                   }
                   return null;
                 },
                 controller: controller.dotPcsController,
                 title: "Dot Pcs",
               ),
               MlgdTextFormWidget(
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Inclusion Pcs';
                   }
                   return null;
                 },
                 controller: controller.inclusionPcsController,
                 title: "Inclusion Pcs",
                 // onChanged: (xyz) {
                 //   checkSum();
                 // },
               ),
               MlgdTextFormWidget(
                 controller: controller.xController,
                 title: "X",
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter X';
                   }
                   return null;
                 },
               ),
               MlgdTextFormWidget(
                 controller: controller.yController,
                 title: "Y",
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Y';
                   }
                   return null;
                 },
               ),
               MlgdTextFormWidget(
                 controller: controller.zController,
                 title: "Z",
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter Z';
                   }
                   return null;
                 },
               ),
               MlgdTextFormWidget(
                 controller: controller.tController,
                 title: "T",
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Please enter T';
                   }
                   return null;
                 },
               ),

             ],
           ),
         ),
       ),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });
   }
   void deleteMlgdData({required BuildContext context , required int mlgdId}){
     AlertDialog alertDialog =  AlertDialog(
       actions: [
         ElevatedButton(
           onPressed: ()=>Get.back(),
           style: ElevatedButton.styleFrom(

               backgroundColor: Colors.redAccent,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10))),
           child: const Text("Cancel"),
         ),
         ElevatedButton(
           onPressed: () {
             controller.deleteMlgdData(mlgdId: mlgdId);

           },
           style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green.shade600,
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10))),
           child: const Text("Submit"),
         ),
       ],
       content: const Text("Are You Sure Want to Delete ?"),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });
   }
}
