import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../controllers/chiller_reading_controller.dart';

class ChillerReadingView extends GetView<ChillerReadingController> {
   ChillerReadingView({Key? key}) : super(key: key);
  final chillerReadingController = Get.put(ChillerReadingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chiller Daily Reading'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20 ,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormWidget(
                  dropDown: true,
                  titleText: "Branch Name" ,
                  dropDownOnChanged: (newValue) {
                    controller.selectedBranch(newValue.toString());
                  },
                  dropDownItems: controller.branch.map((branch) {
                    return DropdownMenuItem<String>(
                      onTap: () {
                        // controller.branchId.value = branch['branch_id'];
                        // controller.branchId.value = controller.branchId.value;
                        // controller.fetchEmployeesByBranchDetails(controller.branchId.value);
                      },
                      value: branch['branch_name'],
                      child: Text(branch['branch_name']),
                    );
                  }).toList()),

              TextFormWidget(dropDown: true, titleText: "Select Phase" ,
                dropDownOnChanged: (newValue) {
                  controller.selectedPhase(newValue.toString());
                },
                dropDownItems: controller.phase.map((phase) {
                  return DropdownMenuItem(
                    value: phase["phaseName"],
                    child: Text(phase["phaseName"]) ,
                  );
                }).toList(),),

              TextBoxWidget(title: "Inlet Temperature", controller: controller.inletTemperature,),
              TextBoxWidget(title: "Outlet Temperature", controller: controller.outletTemperature,),


              TextFormWidget(dropDown: true, titleText: "Select Chiller" ,
                dropDownOnChanged: (newValue) {
                  controller.selectedPhase(newValue.toString());
                },
                dropDownItems: controller.chiller.map((chiller) {
                  return DropdownMenuItem(
                    value: chiller["chillerName"],
                    child: Text(chiller["chillerName"]) ,
                  );
                }).toList(),),


              TextBoxWidget(title: "Average Load", controller: controller.averageLoad,),

              const Text("Compressor Status" , style: TextStyle(
                  color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),),
              Obx(()=>
                  MyRadioList(
                    title: 'ON',
                    value: 'on',
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.status.value = value.toString();
                    },
                  ),
              ),
              Obx(()=>
                  MyRadioList(
                    title: 'OFF',
                    value: 'off',
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.status.value = value.toString();
                    },
                  ),
              ),

              ElevatedButton(onPressed: (){}, child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
