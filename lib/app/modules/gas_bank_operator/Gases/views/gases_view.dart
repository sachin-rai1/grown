import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/widgets.dart';
import '../controllers/gases_controller.dart';

class GasesView extends GetView<GasesController> {
   GasesView({Key? key}) : super(key: key);
  final gasesController = Get.put(GasesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          MaterialButton(
            onPressed: () {
              addGasDialogBox(context);
            },
            child: const Icon(Icons.add_circle ,color: Colors.deepOrange, size: 50,),
          ),
        ],
        title: const Text('GasesView'),
        centerTitle: true,
      ),
      body: Obx(()=>
      (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),):
      (controller.gasesData.isEmpty)?const Center(child: Text("No Data Found"),):
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.gasesData.length,
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
                          const Text('Gas Id : ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.gasesData[index]["gases_id"].toString() , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>updateGasDialogBox(context ,controller.gasesData[index]["gases_name"] ,controller.gasesData[index]["gases_id"]  ), child: const Icon(Icons.edit_note_outlined , color: Colors.green,size: 30,))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Gas Name : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.gasesData[index]["gases_name"] ,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>deleteGas(context, controller.gasesData[index]["gases_id"]), child: const Icon(Icons.delete_forever , color: Colors.red,size: 30,))
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

  void addGasDialogBox(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.addGases() , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(dropDown: false, titleText: 'Gas Name',textController: controller.addGasNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void updateGasDialogBox(BuildContext context , String text , int id) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.updateGases(id) , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(
            hintText: text,
            dropDown: false, titleText: 'Gas Name',textController: controller.updateGasNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void deleteGas(BuildContext context, int id) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteGas(id);
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
