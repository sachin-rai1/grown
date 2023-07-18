import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../data/widgets.dart';
import '../controllers/pcc_data_controller.dart';

class PccDataView extends GetView<PccDataController> {
   PccDataView({Key? key}) : super(key: key);

  final pccDataController = Get.put(PccDataController());

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: const Text('PCC DATA VIEW'),
         centerTitle: true,
       ),
       floatingActionButton: IconButton(
         icon:const Icon(
           Icons.add_circle_outlined,
           size: 55,
           color: Colors.indigoAccent,
         ),
         onPressed: () {
           addPccData(context);
         },
       ),
       body:

       Obx(() =>(controller.isLoadings.value == true)
           ?
       const Center(child: CircularProgressIndicator())
           :
       (controller.pccNameList.isEmpty)
           ?
        Center(child: Lottie.asset('assets/lottie/no_data_found.json'),)
           :
       ListView.builder(
           itemCount: controller.pccNameList.length,
           itemBuilder: (context, index) {
             return Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10),
               child: Card(
                 color: Colors.lightGreenAccent.shade100,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           InkWell(
                             onTap: () {
                               updatePcc(context: context,
                                 id: controller.pccNameList[index].pccId!,
                                 pccName: controller.pccNameList[index].pccName!,

                               );

                             },
                             child: const Icon(Icons.edit, color: Colors.blue,),
                           ),
                          const SizedBox(width: 20,),
                           InkWell(
                             onTap: () {
                               deletePccData(context: context,
                                 id: controller.pccNameList[index].pccId!,);
                             },
                             child: const Icon(Icons.delete, color: Colors.redAccent,
                             ),
                           ),
                         ],
                       ),
                       MyTextWidget( title:"Branch Name : ",body: controller.pccNameList[index].branchName,),
                       MyTextWidget( title:"PCC Name : ",body: controller.pccNameList[index].pccName,),
                       MyTextWidget( title:"Date : ",body: controller.pccNameList[index].createdOn,),

                     ],
                   ),
                 ),
               ),
             );
           }),
       ),
     );
   }


//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____//_____


  void addPccData(BuildContext context)
  {
    AlertDialog alertDialog = AlertDialog(

      actions: [
        ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Cancel")
        ),
        ElevatedButton(
            onPressed: () => controller.pccInsertData(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Submit")
        ),
      ],

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBoxWidget(title: "Add PCC", controller: controller.pccNameController , keyboardType: TextInputType.text),
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (context)
      {
        return alertDialog;
      },
    );
  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________


  void updatePcc ({required BuildContext context,required int id,required String pccName })
  {
    controller.upDatePccNameController.text = pccName;

    AlertDialog alertDialog = AlertDialog(

      actions: [
        ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Cancel")
        ),
        ElevatedButton(
            onPressed: () {
              controller.updatePccName(id: id,);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            child: const Text("Submit")
        ),
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextBoxWidget(title: "Update PCC", controller: controller.upDatePccNameController , keyboardType: TextInputType.text,),

        ],
      ),

    );
    showDialog(
      context: context,
      builder: (context)
      {
        return alertDialog;
      },
    );
  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________



  void deletePccData({required BuildContext context, required int id,})
  {
    AlertDialog alertDialog = AlertDialog(
        actions: [
          ElevatedButton(onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("NO"),),

          ElevatedButton(onPressed: () {
            controller.deletePccData(id:id);
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("YES"),),

        ],

        content: Text("Are You Sure Want to Delete $id ")
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }
}
