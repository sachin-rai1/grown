import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../../controllers/chiller_reading_controller.dart';
import '../controllers/chiller_compressor_controller.dart';

class ChillerCompressorView extends GetView<ChillerCompressorController> {
   ChillerCompressorView({Key? key}) : super(key: key);

  final chillerCompressorController = Get.put(ChillerCompressorController());
   final chillerReadingController = Get.put(ChillerReadingController());
   @override
   Widget build(BuildContext context) {
     var w = MediaQuery.of(context).size.width;
     return Scaffold(
       appBar: AppBar(
         actions: [
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
             child: IconButton(onPressed: () {
               addCompressor(context);
             },
                 icon: const Icon(Icons.add_circle),
                 iconSize: 45,
                 color: Colors.blue),
           ),],
         title: const Text('Compressor'),
         centerTitle: true,
       ),
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20),
         child: Column(
           children: [
             Obx(() =>
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
                 dropDownValue: chillerReadingController
                     .branchDataList[0]["branch_name"],
                 dropDown: true,
                 titleText: "Branch",
                 dropDownOnChanged: (newValue) {
                   chillerReadingController.selectedBranch(newValue.toString());
                 },
                 dropDownItems:
                 chillerReadingController.branchDataList.map((branch) {
                   return DropdownMenuItem<String>(
                     onTap: () async {
                       controller.selectedBranchId.value = branch["branch_id"];
                       controller.selectedBranchName.value = branch["branch_name"];
                       await controller.fetchPhases(branchId: controller.selectedBranchId.value);
                       if(controller.phaseDataList.isEmpty){
                         controller.chillerDataList.value = [];
                       }
                       else {
                         await controller.fetchChiller(phaseId: controller.phaseDataList[0].phaseId!);
                       }

                       if(controller.chillerDataList.isEmpty){
                         controller.compressorDataList.value = [];
                       }
                       else{
                         controller.fetchCompressor(chillerId: controller.chillerDataList[0].chillerId!);
                         controller.selectedChillerId.value = controller.chillerDataList[0].chillerId!;
                       }
                     },
                     value: branch['branch_name'],
                     child: Text(branch['branch_name']),
                   );
                 }).toList())),

             Obx(() =>
             (controller.isLoading.value == true) ? SizedBox(
                 width: (privilage.value == "Admin" ||
                     privilage.value == "Editor")
                     ? w / 1.5
                     : w / 1.2,
                 child: const Center(
                   child: CircularProgressIndicator(),
                 )) : (controller.phaseDataList.isEmpty)
                 ? SizedBox(
                 width: (privilage.value == "Admin" ||
                     privilage.value == "Editor")
                     ? w / 1.5
                     : w / 1.2,
                 child: const Center(
                   child: Text("No Phase Found for selected branch",
                     style: TextStyle(
                         color: Colors.red, fontWeight: FontWeight.w500),),
                 ))
                 : TextFormWidget(
                 dropDownValue: controller.phaseDataList[0].phaseName,
                 dropDown: true,
                 titleText: "Phase",
                 dropDownOnChanged: (newValue) {
                 },
                 dropDownItems:
                 controller.phaseDataList.map((phase) {
                   return DropdownMenuItem<String>(
                     onTap: () async {
                       controller.selectedPhaseId.value = phase.phaseId!;
                       controller.selectedPhaseName.value = phase.phaseName!;
                       await controller.fetchChiller(phaseId: controller.selectedPhaseId.value);
                       if(controller.chillerDataList.isEmpty){
                         controller.compressorDataList.value = [];
                       }
                       else {
                         await controller.fetchCompressor(chillerId: controller.chillerDataList[0].chillerId!);
                         controller.selectedChillerId.value = controller.chillerDataList[0].chillerId!;
                       }
                     },
                     value: phase.phaseName,
                     child: Text(phase.phaseName!),
                   );
                 }).toList())),
             Obx(() =>
             (controller.isChillerLoading.value == true) ? SizedBox(
                 width: (privilage.value == "Admin" ||
                     privilage.value == "Editor")
                     ? w / 1.5
                     : w / 1.2,
                 child: const Center(
                   child: CircularProgressIndicator(),
                 )) : (controller.chillerDataList.isEmpty)
                 ? SizedBox(
                 width: (privilage.value == "Admin" ||
                     privilage.value == "Editor")
                     ? w / 1.5
                     : w / 1.2,
                 child: const Center(
                   child: Text("No Chiller Found for selected Phase",
                     style: TextStyle(
                         color: Colors.red, fontWeight: FontWeight.w500),),
                 ))
                 : TextFormWidget(
                 dropDownValue: controller.chillerDataList[0].chillerName,
                 dropDown: true,
                 titleText: "Chiller",
                 dropDownOnChanged: (newValue) {
                   controller.selectedChiller(newValue.toString());
                 },
                 dropDownItems:
                 controller.chillerDataList.map((chiller) {
                   return DropdownMenuItem<String>(
                     onTap: () async {
                       controller.selectedChillerId.value = chiller.chillerId!;
                       await controller.fetchCompressor(chillerId: controller.selectedChillerId.value);
                     },
                     value: chiller.chillerName,
                     child: Text(chiller.chillerName!),
                   );
                 }).toList())),

             Expanded(
               child: Obx(() {
                 return (controller.isCompressorLoading.value == true)?const Center(child: CircularProgressIndicator()):
                 (controller.compressorDataList.isEmpty)?const Center(child: Text("No Compressor Found" , style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.red, fontSize: 20),)):
                 ListView.builder(
                     physics: const BouncingScrollPhysics(),
                     itemCount: controller.compressorDataList.length,
                     itemBuilder: (context, index) {
                       return Card(
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                                   IconButton(onPressed: (){
                                     updateCompressor(context: context, compressorName: controller.compressorDataList[index].compressorName!, compressorID: controller.compressorDataList[index].compressorId!,
                                     );
                                   }, icon: const Icon(Icons.mode_edit_outlined) , color: Colors.green,iconSize: 30,),
                                   IconButton(onPressed: (){
                                     deleteCompressor(context: context, compressorId:controller.compressorDataList[index].compressorId!);
                                   }, icon: const Icon(Icons.delete_sweep) , color: Colors.red,iconSize: 30,)
                                 ],
                               ),
                               MyTextWidget(title: "Branch Name : ", body: controller.selectedBranchName.value,isLines: false),
                               MyTextWidget(title: "Phase Name : ", body: controller.selectedPhaseName.value,isLines: false),
                               MyTextWidget(title: "Chiller Name  : ", body: controller.compressorDataList[index].chillerName.toString(),isLines: false),
                               MyTextWidget(title: "Compressor Name  : ", body: controller.compressorDataList[index].compressorName.toString(),isLines: false),

                             ],
                           ),
                         ),
                       );
                     });
               }),
             )

           ],
         ),
       ),

     );
   }

   void addCompressor(BuildContext context) {
     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Add Compressor"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.addCompressor(), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

         ],
         content: Column(
             mainAxisSize: MainAxisSize.min,
             children : [
               TextFormWidget(dropDown: false, titleText: "Compressor Name" , textController: controller.compressorNameController,),
             ]
         ),
       );
     });
   }
   void updateCompressor({required BuildContext context , required String compressorName , required int compressorID}) {
     controller.updateCompressorNameController.text = compressorName;

     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Update Compressor"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.updateCompressor(compressorId: compressorID), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

         ],
         content: Column(
             mainAxisSize: MainAxisSize.min,
             children : [
               TextFormWidget(dropDown: false, titleText: "Compressor Name" , textController: controller.updateCompressorNameController,),
             ]
         ),
       );
     });
   }
   void deleteCompressor({required BuildContext context, required int compressorId}){
     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Are you Sure Want to delete"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.deleteCompressor(compressorId: compressorId), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Delete")),
         ],
       );
     });
   }
}
