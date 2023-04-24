import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/widgets.dart';
import '../controllers/gas_vendor_controller.dart';

class GasVendorView extends GetView<GasVendorController> {
   GasVendorView({Key? key}) : super(key: key);
  final gasVendorController = Get.put(GasVendorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              addVendorDialogBox(context);
            },
            child: const Icon(Icons.add_circle ,color: Colors.greenAccent, size: 50,),

          ),
        ],
        title: const Text('GasVendorView'),
        centerTitle: true,
      ),
      body: Obx(()=>
      (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),):
      (controller.vendorData.isEmpty)?const Center(child: Text("No Data Found"),):
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.vendorData.length,
          itemBuilder: (context , index){
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Vendor Id : ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.vendorData[index]["vendor_id"].toString() , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>updateVendorDialogBox(context ,controller.vendorData[index]["vendor_name"] ,controller.vendorData[index]["vendor_id"]  ), child: const Icon(Icons.edit_note_outlined , color: Colors.green,size: 30,))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Vendor Name : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.vendorData[index]["vendor_name"] ,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>deleteVendorDialogBox(context, controller.vendorData[index]["vendor_id"]), child: const Icon(Icons.delete_forever , color: Colors.red,size: 30,))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      ),

    );
  }
  void addVendorDialogBox(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.addVendor() , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(dropDown: false, titleText: 'Vendor Name',textController: controller.addVendorNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void updateVendorDialogBox(BuildContext context , String text , int id) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.updateVendor(id) , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(
            hintText: text,
            dropDown: false, titleText: 'Vendor Name',textController: controller.updateVendorNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void deleteVendorDialogBox(BuildContext context, int id) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteVendor(id);
            },
            child: const Text("Confirm")),
        ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel")),
      ],
    );

    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
