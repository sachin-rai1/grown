import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/view_post_run_data_controller.dart';

class ViewPostRunDataView extends GetView<ViewPostRunDataController> {
   ViewPostRunDataView({Key? key}) : super(key: key);

   final viewPostRunDataController = Get.put(ViewPostRunDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: controller.postRunDataList.length,
          itemBuilder: (context,index){
        return Column(
          children: [
            MyTextWidget(title: "Final Height",body: controller.postRunDataList[index].finalHeight!.toString(),),
            MyTextWidget(title: "New Growth Height",body: controller.postRunDataList[index].newGrowthHeight!.toString(),),


          ],
        );
      })
    );
  }
}
