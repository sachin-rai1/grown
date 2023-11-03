import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/controllers/chiller_reading_controller.dart';

import '../../../../data/constants.dart';
import '../../../../data/widgets.dart';
import '../controllers/chiller_phase_controller.dart';

class ChillerPhaseView extends GetView<ChillerPhaseController> {
  ChillerPhaseView({Key? key}) : super(key: key);

  final chillerPhaseController = Get.put(ChillerPhaseController());
  final chillerReadingController = Get.put(ChillerReadingController());


  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chiller Phase'),
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
                    onTap: () {
                      controller.selectedBranchId.value = branch["branch_id"];
                      controller.fetchPhases(
                          branchId: controller.selectedBranchId.value);
                    },
                    value: branch['branch_name'],
                    child: Text(branch['branch_name']),
                  );
                }).toList())),
            Expanded(
              child: Obx(() {
                return (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator()):
                (controller.phaseDataList.isEmpty)?const Center(child: Text("No Phase Found" , style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.red, fontSize: 20),)):
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.phaseDataList.length,
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
                                    updatePhaseData(context: context,
                                        branchId: controller.phaseDataList[index].branchId!,
                                        branchName: controller.phaseDataList[index].branchName!,
                                        phaseName: controller.phaseDataList[index].phaseName!,
                                        phaseId: controller.phaseDataList[index].phaseId!);
                                  }, icon: const Icon(Icons.mode_edit_outlined) , color: Colors.green,iconSize: 30,),
                                  IconButton(onPressed: (){
                                    deletePhase(context: context, phaseID: controller.phaseDataList[index].phaseId!);
                                  }, icon: const Icon(Icons.delete_sweep) , color: Colors.red,iconSize: 30,)
                                ],
                              ),
                              MyTextWidget(title: "Branch Name : ", body: controller.phaseDataList[index].phaseName.toString(),isLines: false),
                              MyTextWidget(title: "Phase Name  : ", body: controller.phaseDataList[index].branchName.toString(),isLines: false),
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
      floatingActionButton: IconButton(onPressed: () {
        addPhaseData(context);
      },
          icon: const Icon(Icons.add_circle),
          iconSize: 60,
          color: Colors.blue),
    );
  }

  void addPhaseData(BuildContext context) {

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Add Phase"),
        actions: [
          ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
          ElevatedButton(onPressed: ()=>controller.addPhase(), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children : [
            TextFormWidget(dropDown: false, titleText: "Phase Name" , textController: controller.phaseNameController,),
          ]
        ),
      );
    });
  }
  void updatePhaseData({required BuildContext context ,required int branchId , required String branchName, required String phaseName , required int phaseId}) {

    controller.updatePhaseNameController.text = phaseName;

    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Update Phase"),
        actions: [
          ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Cancel") ,),
          ElevatedButton(onPressed: ()=>controller.updatePhase(phaseId: phaseId), style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent), child: const Text("Submit")),

        ],
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children : [
              TextFormWidget(dropDown: false, titleText: "Phase Name" , textController: controller.updatePhaseNameController,),
            ]
        ),
      );
    });
  }
  void deletePhase({required BuildContext context, required int phaseID}){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Are you Sure Want to delete"),
        actions: [
          ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green), child: const Text("Cancel") ,),
          ElevatedButton(onPressed: ()=>controller.deletePhase(phaseId: phaseID), style: ElevatedButton.styleFrom(backgroundColor: Colors.red), child: const Text("Delete")),
        ],
      );
    });
  }
}