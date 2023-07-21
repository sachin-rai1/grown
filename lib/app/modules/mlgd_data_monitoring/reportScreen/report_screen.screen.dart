import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/post_run/date_wise_post_run_data/views/date_wise_post_run_data_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/post_run/run_no_wise_post_run_data/views/view_post_run_data_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/date_wise_pre_run_data/views/date_wise_pre_run_data_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/pre_run_view_data/views/pre_run_view_data_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/running_data/Graph/running_data_graph.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/running_data/view_running_data_date_wise/views/view_mlgd_data_date_wise_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/running_data/view_running_data_run_wise/views/view_mlgd_data_run_wise_view.dart';

import 'controllers/report_screen.controller.dart';


class ReportScreenScreen extends GetView<ReportScreenController> {
  const ReportScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Screen'),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){
                Get.to(() => ReportTabBar(
                  title: const Text("Running Data Report"),
                  tabs: const [
                  Text("DateWise Data"),
                  Text("RunWise Data"),
                ], children: [
                  ViewMlgdDataDateWiseView(),
                  ViewMlgdDataRunWiseView()
                ],));
              }, style: ElevatedButton.styleFrom(
                fixedSize: Size(w/1.5, h/6),
                textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ), child: const Text("Running Data") ,),
              ElevatedButton(onPressed: (){
                Get.to(()=> ReportTabBar(
                  tabs: const [
                    Text("Running Graph")
                  ],
                  title: const Text("Graph"),
                  children: [
                    RunningDataGraph()
                  ],));
              }, style: ElevatedButton.styleFrom(
                  fixedSize: Size(w/1.5, h/6),
                  textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ), child: const Text("View Graph") ,),
              ElevatedButton(onPressed: (){
                Get.to(() => ReportTabBar(
                  title: const Text("Pre-Run Data Report"),
                  tabs: const [
                  Text("DateWise Data"),
                  Text("RunWise Data"),
                ], children: [
                  DateWisePreRunDataView(),
                  PreRunViewDataView()
                ],));
              }, style: ElevatedButton.styleFrom(
                  fixedSize: Size(w/1.5, h/6),
                  textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ), child: const Text("Pre-Run Data") ,),
              ElevatedButton(onPressed: (){
                Get.to(() => ReportTabBar(
                  title: const Text("Post-Run Data Report"),
                  tabs: const [
                    Text("DateWise Data"),
                    Text("RunWise Data"),
                  ], children: [
                   DateWisePostRunDataView(),
                  ViewPostRunDataView()
                ],));
              }, style: ElevatedButton.styleFrom(
                  fixedSize: Size(w/1.5, h/6),
                  textStyle: const TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ), child: const Text("Post-Run Data") ,),
            ],
          ),
        ),
      ),
    );
  }
}
