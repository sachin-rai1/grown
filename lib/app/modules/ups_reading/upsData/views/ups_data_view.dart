import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/ups_data_controller.dart';

class UpsDataView extends GetView<UpsDataController> {
  UpsDataView({Key? key}) : super(key: key);
  final upsDataController = Get.put(UpsDataController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ups'),
        centerTitle: true,
      ),
      body: Obx(
        () => (controller.isLoading.value == true)
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.upsDataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Card(
                      elevation: 2,
                      color: Colors.deepPurple.shade50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      updateUpsData(context: context, id: controller.upsDataList[index].upsId!, upsName: controller.upsDataList[index].upsName!);
                                    },
                                    icon: const Icon(
                                        Icons.mode_edit_outline_outlined)),
                                IconButton(
                                    onPressed: () {
                                      deleteUpsData(context: context, upsName: controller.upsDataList[index].upsName!, id: controller.upsDataList[index].upsId!);
                                    },
                                    icon: const Icon(Icons.delete_sweep)),
                              ],
                            ),
                            MyTextWidget(
                              title: "Ups Id :  ",
                              isLines: false,
                              body: controller.upsDataList[index].upsId
                                  .toString(),
                            ),
                            MyTextWidget(
                              title: "Ups Name :  ",
                              isLines: false,
                              body: controller.upsDataList[index].upsName!,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
      ),
      floatingActionButton: IconButton(
        iconSize: w * 0.15,
        color: Colors.deepPurple,
        onPressed: () {
          addUpsData(context);
        },
        icon: const Icon(Icons.add_circle),
      ),
    );
  }

  void addUpsData(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      contentPadding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
      actions: [
        ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Cancel")),
        ElevatedButton(onPressed: ()=>controller.addUpsData(), style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Submit")),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(dropDown: false, titleText: "Ups Name" , textController: controller.addUpsNameController,)
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
  void updateUpsData({required BuildContext context , required int id , required String upsName}) {
    AlertDialog alertDialog = AlertDialog(
      contentPadding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
      actions: [
        ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Cancel")),
        ElevatedButton(onPressed: ()=>controller.updateUpsData(id: id), style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Submit")),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormWidget(dropDown: false, titleText: "Ups Name" , textController: controller.updateUpsNameController,hintText: upsName,)
        ],
      ),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
  void deleteUpsData({required BuildContext context , required String upsName , required int id}) {
    AlertDialog alertDialog = AlertDialog(
      contentPadding: const EdgeInsets.only(left: 10 , right: 10 , top: 10),
      actions: [
        ElevatedButton(onPressed: ()=>Get.back(), style: ElevatedButton.styleFrom(backgroundColor: Colors.red , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("No")),
        ElevatedButton(onPressed: ()=>controller.deleteUpsData(id: id), style: ElevatedButton.styleFrom(backgroundColor: Colors.green , shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))), child: const Text("Yes")),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text("Are You Sure want to delete $upsName")
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
}
