
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/reportScreen/report_screen.screen.dart';
import '../controllers/mlgd_data_monitoring_controller.dart';

class MlgdDataMonitoringView extends GetView<MlgdDataMonitoringController> {
  MlgdDataMonitoringView({Key? key}) : super(key: key);
  final mlgdDataMonitoringController = Get.put(MlgdDataMonitoringController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Get.back();
          },
            child: const Icon(Icons.home , size: 35, semanticLabel: "back",)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.green,
                  height: height / 3,
                  minWidth: width,
                  onPressed: () {
                    Get.to(()=> const MlgdDataEntryTabBar());
                  },
                  elevation: 2,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Icon(Icons.data_exploration , size: height*0.1,),
                       const Text("DATA ENTRY"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.orange,
                    height: height / 3,
                    minWidth: width,
                    onPressed: () {
                      Get.to(()=> const ReportScreenScreen());
                    },
                    child: Column(
                      children:  [
                        Icon(Icons.summarize_sharp , size: height*0.1),
                         const Text("VIEW REPORT"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}


