import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../controllers/ups_reading_controller.dart';

class UpsReadingView extends GetView<UpsReadingController> {
   UpsReadingView({Key? key}) : super(key: key);
  final upsReadingController = Get.put(UpsReadingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UPS Monitoring/ Reading Form'),
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

              TextFormWidget(dropDown: true, titleText: "Select Ups" ,
                dropDownOnChanged: (newValue) {
                  controller.selectedUps(newValue.toString());
                },
                dropDownItems: controller.ups.map((ups) {
                  return DropdownMenuItem(
                    value: ups["upsName"],
                    child: Text(ups["upsName"]) ,
                  );
                }).toList(),),

              TextBoxWidget(title: "Load On Ups R", controller: controller.loadOnUpsR,),
              TextBoxWidget(title: "Load On Ups Y", controller: controller.loadOnUpsY,),
              TextBoxWidget(title: "Load On Ups B", controller: controller.loadOnUpsB,),
              const Text("Led Status" , style: TextStyle(
                  color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),),
              Obx(()=>
                  MyRadioList(
                    title: 'Red',
                    value: 'red',
                    activeColor: Colors.red,
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.status.value = value.toString();
                    },
                  ),
              ),
              Obx(()=>
                  MyRadioList(
                    activeColor: Colors.green,
                    title: 'Green',
                    value: 'green',
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.status.value = value.toString();
                    },
                  ),
              ),
              Obx(()=>
                  MyRadioList(
                    activeColor: Colors.orange,
                    title: 'Orange',
                    value: 'orange',
                    groupValue: controller.status.value,
                    onChanged: (value) {
                      controller.status.value = value.toString();
                    },
                  ),
              ),
              const SizedBox(height: 10,),

              TextBoxWidget(title: "DC Positive Voltage", controller: controller.positiveVoltage,),
              TextBoxWidget(title: "DC Negative Voltage", controller: controller.negativeVoltage,),
              ElevatedButton(onPressed: (){}, child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
