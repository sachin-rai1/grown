import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../../controllers/chiller_reading_controller.dart';
import '../controllers/process_pump_controller.dart';

class ProcessPumpView extends GetView<ProcessPumpController> {
   ProcessPumpView({Key? key}) : super(key: key);
   final processPumpController = Get.put(ProcessPumpController());
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
               addProcessPump(context);
             },
                 icon: const Icon(Icons.add_circle),
                 iconSize: 45,
                 color: Colors.blue),
           ),],
         title: const Text('Process Pump'),
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
                         controller.processPumpDataList.value = [];
                       }
                       else {
                         await controller.fetchProcessPump(
                             phaseId: controller.phaseDataList[0].phaseId!);
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
                   // controller.selectedPhase(newValue.toString());
                 },
                 dropDownItems:
                 controller.phaseDataList.map((phase) {
                   return DropdownMenuItem<String>(
                     onTap: () {
                       controller.selectedPhaseId.value = phase.phaseId!;
                       controller.fetchProcessPump(phaseId: controller.selectedPhaseId.value);
                     },
                     value: phase.phaseName,
                     child: Text(phase.phaseName!),
                   );
                 }).toList())),

             Expanded(
               child: Obx(() {
                 return (controller.isProcessPumpLoading.value == true)?const Center(child: CircularProgressIndicator()):
                 (controller.processPumpDataList.isEmpty)?const Center(child: Text("No Process Pump Found" , style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.red, fontSize: 20),)):
                 ListView.builder(
                     physics: const BouncingScrollPhysics(),
                     itemCount: controller.processPumpDataList.length,
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
                                     updateProcessPump(context: context, processPumpName: controller.processPumpDataList[index].processPumpName!, cppId: controller.processPumpDataList[index].cppId!,
                                     );
                                   }, icon: const Icon(Icons.mode_edit_outlined) , color: Colors.green,iconSize: 30,),
                                   IconButton(onPressed: (){
                                     deleteProcessPump(context: context, cppId:controller.processPumpDataList[index].cppId!);
                                   }, icon: const Icon(Icons.delete_sweep) , color: Colors.red,iconSize: 30,)
                                 ],
                               ),
                               MyTextWidget(title: "Branch Name : ", body: controller.selectedBranchName.value,isLines: false),
                               MyTextWidget(title: "Phase Name : ", body: controller.processPumpDataList[index].phaseName.toString(),isLines: false),
                               MyTextWidget(title: "Process Pump Name  : ", body: controller.processPumpDataList[index].processPumpName.toString(),isLines: false),
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

   void addProcessPump(BuildContext context) {
     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Add Process Pump"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.addProcessPump(), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

         ],
         content: Column(
             mainAxisSize: MainAxisSize.min,
             children : [
               TextFormWidget(dropDown: false, titleText: "Process Pump Name" , textController: controller.processPumpNameController,),
             ]
         ),
       );
     });
   }
   void updateProcessPump({required BuildContext context , required String processPumpName , required int cppId}) {

     controller.updateProcessPumpNameController.text = processPumpName;

     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Update Process Pump"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.updateProcessPump(cppId: cppId), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

         ],
         content: Column(
             mainAxisSize: MainAxisSize.min,
             children : [
               TextFormWidget(dropDown: false, titleText: "Process Pump Name" , textController: controller.updateProcessPumpNameController,),
             ]
         ),
       );
     });
   }
   void deleteProcessPump({required BuildContext context, required int cppId}){
     showDialog(context: context, builder: (context){
       return AlertDialog(
         title: const Text("Are you Sure Want to delete"),
         actions: [
           ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Cancel") ,),
           ElevatedButton(onPressed: ()=>controller.deleteProcessPump(cppId: cppId), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Delete")),
         ],
       );
     });
   }
}
