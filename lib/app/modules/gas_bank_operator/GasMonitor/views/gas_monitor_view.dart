import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../data/widgets.dart';
import '../../../employee_management/branch_data/views/branch_data_view.dart';
import '../../Gases/views/gases_view.dart';
import '../controllers/gas_monitor_controller.dart';

class GasMonitorView extends GetView<GasMonitorController> {
   GasMonitorView({Key? key}) : super(key: key);

   final gasMonitorController = Get.put(GasMonitorController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: ()=>Get.back(), icon: const Icon(Icons.home_filled),iconSize: 35,),
        elevation: 0,
        title: const Text('GasMonitorView'),
        actions: [
          MaterialButton(
            elevation: 2,
            shape: const CircleBorder(),
            onPressed: (){
              addGasMonitorData(context);
            },
            child: const Icon(Icons.add_circle ,color: Colors.purpleAccent, size: 50,),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: RefreshIndicator(
          onRefresh: () {
            return Future(
                    () => controller.onInit()
            );
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(()=>
                Column(
                  children: [
                     dropDowns(context),
                    if (controller.isLoading.value == true)
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                          child: const Center(child: CircularProgressIndicator()))
                    else
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          viewOnlineGases(context),
                          viewStandbyGases(context),
                          viewStockGases(context),
                        ],
                      ),

                  ],
                ),
            ),
          ),
        ),
      ),

    );
  }
   dropDowns(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
     return Obx(()=>
     (controller.isDropDownLoading.value)?SizedBox(width:MediaQuery.of(context).size.width / 2, child: const Center(child: CircularProgressIndicator())):
        Column(
         children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Obx(
                   () => TextFormWidget(
                     dropDownValue:controller.branchDataList[0]['branch_name'],
                 dropDown: true,
                 titleText: "Select Branch",
                 dropDownOnChanged: (value) {
                   log(value.toString());
                 },
                 dropDownWidth: w / 1.5,
                 dropDownItems: controller.branchDataList.map((branch) {
                   return DropdownMenuItem<String>(
                       value: branch["branch_name"],
                       onTap: () {
                         controller.selectedBranchId.value =
                         branch["branch_id"];
                         controller.fetchGasMonitorData(
                             controller.selectedBranchId.value,
                             controller.selectedGasId.value);
                       },
                       child: Text(branch["branch_name"]));
                 }).toList(),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 15),
               child: MaterialButton(
                 onPressed: () {
                   Get.to(() => BranchDataView());
                 },
                 shape: const CircleBorder(),
                 child: const Icon(
                   Icons.add_circle,
                   size: 50,
                   color: Colors.purple,
                 ),
               ),
             ),
           ],
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Obx(
                   () =>TextFormWidget(
                     dropDownValue: controller.gasDataList[0]["gases_name"],
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.gasDataList.map((gases) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedGasId.value =
                         gases["gases_id"];
                         controller.fetchGasMonitorData(
                             controller.selectedBranchId.value,
                             controller.selectedGasId.value);
                       },
                       value: gases["gases_name"],
                       child: Text(gases["gases_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Gas",
                   dropDownWidth: w / 1.5),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 15),
               child: MaterialButton(
                 onPressed: () {
                   Get.to(() => GasesView());
                 },
                 shape: const CircleBorder(),
                 child: const Icon(
                   Icons.add_circle,
                   size: 50,
                   color: Colors.purple,
                 ),
               ),
             ),
           ],
         ),
       ],),
     );
   }
   Widget viewOnlineGases(BuildContext context){
     return Obx(
           () => (controller.onlineGasMonitorDataList.isEmpty)
           ? Container()
           : ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: controller.onlineGasMonitorDataList.length,
           itemBuilder: (context, index) {
             var startingDate = DateFormat("dd-MM-yyyy")
                 .format(DateTime.parse(controller
                 .onlineGasMonitorDataList[index].startingOn
                 .toString()));
             var dueDate = DateFormat("dd-MM-yyyy").format(
                 DateTime.parse(controller
                     .onlineGasMonitorDataList[index].dueDate
                     .toString()));
             return Card(
               color:(controller.onlineGasMonitorDataList[index].remainingStockDays == null)?Colors.greenAccent:(controller.onlineGasMonitorDataList[index].remainingStockDays! <= 0)?Colors.grey: Colors.greenAccent,
               child: Padding(
                 padding: const EdgeInsets.only(
                     top: 10, bottom: 10),
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children:  [
                           InkWell(onTap: (){
                             updateGasMonitorData(context,
                               controller.onlineGasMonitorDataList[index].gasMonitorId!,
                               controller.onlineGasMonitorDataList[index].branchName!,
                               controller.onlineGasMonitorDataList[index].gasName!,
                               controller.onlineGasMonitorDataList[index].statusName!,
                               controller.onlineGasMonitorDataList[index].vendorName!,
                               controller.onlineGasMonitorDataList[index].manifoldName!,
                               controller.onlineGasMonitorDataList[index].serialNo!.toString(),
                               controller.onlineGasMonitorDataList[index].consumption!.toString(),
                               controller.onlineGasMonitorDataList[index].gasQty!.toString(),
                               controller.onlineGasMonitorDataList[index].operatorName!.toString(),
                               controller.onlineGasMonitorDataList[index].branchId!,
                               controller.onlineGasMonitorDataList[index].gasesId!,
                               controller.onlineGasMonitorDataList[index].statusId!,
                               controller.onlineGasMonitorDataList[index].vendorId!,
                               controller.onlineGasMonitorDataList[index].manifoldId!,
                             );
                           }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                           const SizedBox(width: 20,),
                           InkWell(onTap: (){
                             deleteGasMonitorData(context, controller.onlineGasMonitorDataList[index].gasMonitorId! ,controller.onlineGasMonitorDataList[index].branchId! , controller.onlineGasMonitorDataList[index].gasesId! , controller.onlineGasMonitorDataList[index].statusId! ,controller.onlineGasMonitorDataList[index].remainingStockDays! );
                           }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                         ],
                       ),
                     ),
                     const MyTextWidget(
                       title: "Status",
                       body: "Online",
                     ),
                     MyTextWidget(
                       title: "Started On",
                       body: startingDate,
                     ),
                     MyTextWidget(
                       title: "Serial No",
                       body: controller
                           .onlineGasMonitorDataList[index]
                           .serialNo
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Total Qty",
                       body: controller
                           .onlineGasMonitorDataList[index].gasQty
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Balance Qty",
                       body: controller
                           .onlineGasMonitorDataList[index]
                           .remainingStock
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Consumption",
                       body: "${controller.onlineGasMonitorDataList[index].consumption.toString()} bars/day",
                     ),
                     MyTextWidget(
                       title: "Total Days Left",
                       body: controller.onlineGasMonitorDataList[index].remainingStockDays
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Last Date",
                       body: dueDate,
                     ),
                     MyTextWidget(
                       title: "Operator Name",
                       body: controller.onlineGasMonitorDataList[index].operatorName,
                     ),
                   ],
                 ),
               ),
             );
           }),
     );

   }
   Widget viewStandbyGases(BuildContext context){
     return Obx(
           () => (controller.standbyGasMonitorDataList.isEmpty)
           ? Container()
           : ListView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemCount: controller.standbyGasMonitorDataList.length,
           itemBuilder: (context, index) {
             var startingDate = DateFormat("dd-MM-yyyy")
                 .format(DateTime.parse(controller
                 .standbyGasMonitorDataList[index].startingOn
                 .toString()));
             var dueDate = DateFormat("dd-MM-yyyy").format(
                 DateTime.parse(controller
                     .standbyGasMonitorDataList[index].dueDate
                     .toString()));
             return Card(
               color:(controller.standbyGasMonitorDataList[index].remainingStockDays == null)?Colors.red:(controller.standbyGasMonitorDataList[index].remainingStockDays! <= 0)?Colors.grey: Colors.yellow,
               child: Padding(
                 padding: const EdgeInsets.only(
                     top: 10, bottom: 10),
                 child: Column(
                   children: [
                     IconButton(onPressed: (){
                       controller.updateGasMonitorStatus(id: controller.standbyGasMonitorDataList[index].gasMonitorId!, statusId: 2);
                     }, icon: const Icon(Icons.arrow_circle_up_sharp) , iconSize: 50,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children:  [
                           InkWell(onTap: (){
                             updateGasMonitorData(
                               context,
                               controller.standbyGasMonitorDataList[index].gasMonitorId! ,
                               controller.standbyGasMonitorDataList[index].branchName!,
                               controller.standbyGasMonitorDataList[index].gasName!,
                               controller.standbyGasMonitorDataList[index].statusName!,
                               controller.standbyGasMonitorDataList[index].vendorName!,
                               controller.standbyGasMonitorDataList[index].manifoldName!,
                               controller.standbyGasMonitorDataList[index].serialNo!.toString(),
                               controller.standbyGasMonitorDataList[index].consumption!.toString(),
                               controller.standbyGasMonitorDataList[index].gasQty!.toString(),
                               controller.standbyGasMonitorDataList[index].operatorName!.toString(),
                               controller.standbyGasMonitorDataList[index].branchId!,
                               controller.standbyGasMonitorDataList[index].gasesId!,
                               controller.standbyGasMonitorDataList[index].statusId!,
                               controller.standbyGasMonitorDataList[index].vendorId!,
                               controller.standbyGasMonitorDataList[index].manifoldId!,
                             );
                           }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                           const SizedBox(width: 20,),
                           InkWell(onTap: (){
                             deleteGasMonitorData(context, controller.standbyGasMonitorDataList[index].gasMonitorId!  , controller.standbyGasMonitorDataList[index].branchId! , controller.standbyGasMonitorDataList[index].gasesId! , controller.standbyGasMonitorDataList[index].statusId! ,controller.standbyGasMonitorDataList[index].remainingStockDays!);
                           }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                         ],
                       ),
                     ),
                     const MyTextWidget(
                       title: "Status",
                       body: "Stand By",
                     ),
                     MyTextWidget(
                       title: "Starting On",
                       body: startingDate,
                     ),
                     MyTextWidget(
                       title: "Serial No",
                       body: controller.standbyGasMonitorDataList[index].serialNo.toString(),
                     ),
                     MyTextWidget(
                       title: "Total Qty",
                       body: controller
                           .standbyGasMonitorDataList[index].gasQty
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Consumption",
                       body: "${controller.standbyGasMonitorDataList[index].consumption} bars/day",
                     ),
                     MyTextWidget(
                       title: "Total Days Left",
                       body: controller
                           .standbyGasMonitorDataList[index]
                           .remainingStockDays
                           .toString(),
                     ),
                     MyTextWidget(
                       title: "Last Date",
                       body: dueDate,
                     ),
                     MyTextWidget(
                         title: "Operator Name",
                         body: controller.standbyGasMonitorDataList[index].operatorName
                     ),
                   ],
                 ),
               ),
             );
           }),
     );}
   Widget viewStockGases(BuildContext context){
     return Obx(
           () => (controller.stockGasMonitorDataList.isEmpty)
           ? Container()
           : Padding(
         padding: const EdgeInsets.only(bottom: 20),
         child: ListView.builder(
             shrinkWrap: true,
             physics: const NeverScrollableScrollPhysics(),
             itemCount: controller.stockGasMonitorDataList.length,
             itemBuilder: (context, index) {
               var startingDate = DateFormat("dd-MM-yyyy")
                   .format(DateTime.parse(controller
                   .stockGasMonitorDataList[index].startingOn
                   .toString()));
               var dueDate = DateFormat("dd-MM-yyyy").format(
                   DateTime.parse(controller
                       .stockGasMonitorDataList[index].dueDate
                       .toString()));

               return Card(
                 color:(controller.stockGasMonitorDataList[index].remainingStockDays == null)?Colors.red:(controller.stockGasMonitorDataList[index].remainingStockDays! <= 0)?Colors.grey: Colors.cyan,
                 child: Padding(
                   padding: const EdgeInsets.only(
                       top: 10, bottom: 10),
                   child: Column(
                     children: [
                       IconButton(onPressed: (){
                         controller.updateGasMonitorStatus(id: controller.stockGasMonitorDataList[index].gasMonitorId!, statusId: 3);
                       }, icon: const Icon(Icons.arrow_circle_up_sharp) , iconSize: 50,),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children:  [
                             InkWell(onTap: (){
                               updateGasMonitorData(
                                 context,
                                 controller.stockGasMonitorDataList[index].gasMonitorId!,
                                 controller.stockGasMonitorDataList[index].branchName!,
                                 controller.stockGasMonitorDataList[index].gasName!,
                                 controller.stockGasMonitorDataList[index].statusName!,
                                 controller.stockGasMonitorDataList[index].vendorName!,
                                 controller.stockGasMonitorDataList[index].manifoldName!,
                                 controller.stockGasMonitorDataList[index].serialNo!.toString(),
                                 controller.stockGasMonitorDataList[index].consumption!.toString(),
                                 controller.stockGasMonitorDataList[index].gasQty!.toString(),
                                 controller.stockGasMonitorDataList[index].operatorName!.toString(),
                                 controller.stockGasMonitorDataList[index].branchId!,
                                 controller.stockGasMonitorDataList[index].gasesId!,
                                 controller.stockGasMonitorDataList[index].statusId!,
                                 controller.stockGasMonitorDataList[index].vendorId!,
                                 controller.stockGasMonitorDataList[index].manifoldId!,
                               );

                             }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                             const SizedBox(width: 20,),
                             InkWell(onTap: (){
                               deleteGasMonitorData(context, controller.stockGasMonitorDataList[index].gasMonitorId! , controller.stockGasMonitorDataList[index].branchId! , controller.stockGasMonitorDataList[index].gasesId! ,controller.stockGasMonitorDataList[index].statusId! ,controller.stockGasMonitorDataList[index].remainingStockDays! );
                             }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                           ],
                         ),
                       ),
                       const MyTextWidget(
                         title: "Status",
                         body: "In Stock",
                       ),
                       MyTextWidget(
                         title: "Starting On",
                         body: startingDate,
                       ),
                       MyTextWidget(
                         title: "Serial No",
                         body: controller
                             .stockGasMonitorDataList[index].serialNo
                             .toString(),
                       ),
                       MyTextWidget(
                         title: "Total Qty",
                         body: controller
                             .stockGasMonitorDataList[index].gasQty
                             .toString(),
                       ),
                       MyTextWidget(
                         title: "Consumption",
                         body: "${controller.stockGasMonitorDataList[index].consumption} bars/day",
                       ),
                       MyTextWidget(
                         title: "Balance Qty",
                         body: controller
                             .stockGasMonitorDataList[index]
                             .remainingStock
                             .toString(),
                       ),
                       MyTextWidget(
                         title: "Total Days Left",
                         body: controller
                             .stockGasMonitorDataList[index]
                             .remainingStockDays
                             .toString(),
                       ),
                       MyTextWidget(
                         title: "Last Date",
                         body: dueDate,
                       ),
                       MyTextWidget(
                         title: "Operator Name " ,
                         body: controller.stockGasMonitorDataList[index].operatorName.toString(),
                       ),
                     ],
                   ),
                 ),
               );
             }),
       ),
     );}
   void addGasMonitorData(BuildContext context) {
     var w = MediaQuery.of(context).size.height;

     AlertDialog alertDialog = AlertDialog(
       actions: [
         ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
         ElevatedButton(onPressed: ()=>controller.addGasMonitorData(), child: const Text("Submit")),

       ],
       content: SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Obx(
                   () => TextFormWidget(
                 dropDown: true,
                 titleText: "Select Branch",
                 dropDownOnChanged: (value) {
                   log(value.toString());
                 },
                 dropDownWidth: w / 1.6,
                 dropDownItems: controller.branchDataList.map((branch) {
                   return DropdownMenuItem<String>(
                       value: branch["branch_name"],
                       onTap: () {
                         controller.selectedBranchId.value =
                         branch["branch_id"];

                       },
                       child: Text(branch["branch_name"]));
                 }).toList(),
               ),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.gasDataList.map((gases) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedGasId.value = gases["gases_id"];
                       },
                       value: gases["gases_name"],
                       child: Text(gases["gases_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Gas",
                   dropDownWidth: w / 1.6),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.gasStatusDataList.map((status) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedGasStatusId.value = status["status_id"];

                       },
                       value: status["status_name"],
                       child: Text(status["status_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Status",
                   dropDownWidth: w / 1.6),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.vendorDataList.map((vendor) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedVendorId.value =
                         vendor["vendor_id"];

                       },
                       value: vendor["vendor_name"],
                       child: Text(vendor["vendor_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Vendor",
                   dropDownWidth: w / 1.6),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.manifoldDataList.map((manifold) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedManifoldId.value =
                         manifold["manifold_id"];

                       },
                       value: manifold["manifold_name"],
                       child: Text(manifold["manifold_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Manifold",
                   dropDownWidth: w / 1.6),
             ),
             TextFormWidget(dropDown: false, titleText: "Serial No" ,textController: controller.addSerialNoController, ),
             TextFormWidget(dropDown: false, titleText: "Consumption/Day" , textController: controller.addConsumptionNoController,),
             TextFormWidget(dropDown: false, titleText: "Gas Qty" , textController: controller.addGasQtyNoController,),
             TextFormWidget(dropDown: false, titleText: "Operator Name" , textController: controller.addOperatorNameController,),


           ],
         ),
       ),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });

   }
   void updateGasMonitorData(BuildContext context , int id , String branchName , String gasName , String status , String vendorName ,String manifold , String serialNo , String consumption, String gasQty , String operatorName , int branchId , int gasId , int statusId , int vendorId ,int manifoldId ){
     var w = MediaQuery.of(context).size.height;
     AlertDialog alertDialog = AlertDialog(
       actions: [
         ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
         ElevatedButton(onPressed: ()=>controller.updateGasMonitorData(id , serialNo, consumption,  operatorName , gasQty ,  branchId ,  gasId ,  statusId ,  vendorId , manifoldId ), child: const Text("Submit")),

       ],
       content: SingleChildScrollView(
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             Obx(
                   () => TextFormWidget(
                   dropDownValue: status,
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.gasStatusDataList.map((status) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedGasStatusId.value = status["status_id"];

                       },
                       value: status["status_name"],
                       child: Text(status["status_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Status",
                   dropDownWidth: w / 1.6),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownValue: vendorName,
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.vendorDataList.map((vendor) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedVendorId.value =
                         vendor["vendor_id"];

                       },
                       value: vendor["vendor_name"],
                       child: Text(vendor["vendor_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Vendor",
                   dropDownWidth: w / 1.6),
             ),
             Obx(
                   () => TextFormWidget(
                   dropDownValue: manifold,
                   dropDownOnChanged: (value) {},
                   dropDownItems: controller.manifoldDataList.map((manifold) {
                     return DropdownMenuItem<String>(
                       onTap: () {
                         controller.selectedManifoldId.value =
                         manifold["manifold_id"];

                       },
                       value: manifold["manifold_name"],
                       child: Text(manifold["manifold_name"]),
                     );
                   }).toList(),
                   dropDown: true,
                   titleText: "Select Manifold",
                   dropDownWidth: w / 1.6),
             ),
             TextFormWidget(hintText: serialNo, dropDown: false, titleText: "Serial No" ,textController: controller.updateSerialNoController, ),
             TextFormWidget(hintText: consumption, dropDown: false, titleText: "Consumption/Day" , textController: controller.updateConsumptionNoController,),
             TextFormWidget(hintText: gasQty, dropDown: false, titleText: "Gas Qty" , textController: controller.updateGasQtyNoController,),
             TextFormWidget(hintText: operatorName, dropDown: false, titleText: "Operator Name" , textController: controller.updateOperatorNameController,),

           ],
         ),
       ),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });
   }
   void deleteGasMonitorData(BuildContext context , int id , int selectedBranchId , int selectedGasId , int gasStatus , int dueDays){
     AlertDialog alertDialog =  AlertDialog(
       actions: [
         ElevatedButton(onPressed: ()=>Get.back(), child: const Text("Cancel")),
         ElevatedButton(onPressed: ()=>controller.deleteGasMonitorData(id , selectedBranchId , selectedGasId , gasStatus, dueDays), child: const Text("Submit")),
       ],
       content: const Text("Are You Sure Want to Delete ?"),
     );
     showDialog(context: context, builder: (context){
       return alertDialog;
     });
   }
}
