import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/widgets.dart';
import '../controllers/gas_manifold_controller.dart';

class GasManifoldView extends GetView<GasManifoldController> {
   GasManifoldView({Key? key}) : super(key: key);

  final gasManifoldController = Get.put(GasManifoldController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              addManifoldDialogBox(context);
            },
            child: const Icon(Icons.add_circle ,color: Colors.cyanAccent, size: 50,),

          ),
        ],
        title: const Text('GasManifoldView'),
        centerTitle: true,
      ),
      body: Obx(()=>
      (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator(),):
      (controller.manifoldData.isEmpty)?const Center(child: Text("No Data Found"),):
      ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.manifoldData.length,
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
                          const Text('Manifold Id : ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.manifoldData[index]["manifold_id"].toString() , style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>updateManifoldDialogBox(context ,controller.manifoldData[index]["manifold_name"] ,controller.manifoldData[index]["manifold_id"]  ), child: const Icon(Icons.edit_note_outlined , color: Colors.green,size: 30,))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Manifold Name : ",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500 , color: Colors.deepOrange),),
                          Text(controller.manifoldData[index]["manifold_name"] ,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500 )),
                          InkWell(onTap: ()=>deleteManifoldDialogueBox(context, controller.manifoldData[index]["manifold_id"]), child: const Icon(Icons.delete_forever , color: Colors.red,size: 30,))
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
  void addManifoldDialogBox(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.addManifold() , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(dropDown: false, titleText: 'Manifold Name',textController: controller.addManifoldNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void updateManifoldDialogBox(BuildContext context , String text , int id) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(onPressed: ()=>controller.updateManifold(id) , child: const Text("Submit"),),
        ElevatedButton(onPressed: () =>Get.back() , child: const Text("Cancel"),)
      ],

      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(
            hintText: text,
            dropDown: false, titleText: 'Manifold Name',textController: controller.updateManifoldNameController ,),
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }

  void deleteManifoldDialogueBox(BuildContext context, int id) {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Are you sure want to delete ?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              controller.deleteManifold(id);
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
