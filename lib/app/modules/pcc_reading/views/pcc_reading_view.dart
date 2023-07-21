import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/pcc_reading/branchwise_pcc_reading/views/branchwise_pcc_reading_view.dart';
import 'package:grown/app/modules/pcc_reading/insert_pcc_reading/views/insert_pcc_reading_view.dart';

import '../../../data/widgets.dart';
import '../controllers/pcc_reading_controller.dart';
import '../datewise_pcc_reading/views/datewise_pcc_reading_view.dart';

class PccReadingView extends GetView<PccReadingController> {
  const PccReadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade100,
      body: SafeArea(
        child: Scaffold (
          body: ReportTabBar(
            title: const Text("PCC READING"),
            tabs: const [
              Text("Add Reading"),
              Text("DateWise Reading"),
              Text("BranchWise Reading"),
            ],
            children: [
                  InsertPccReadingView(),
                  DatewisePccReadingView(),
                  BranchwisePccReadingView(),
            ],
          ),
          // bottomNavigationBar: MyBottomNavigation(
          //   title1: "Reading",
          //   title2: "DateWise",
          //   title3: "Branch",
          //   screens:
          //   [
          //     InsertPccReadingView(),
          //     DatewisePccReadingView(),
          //     BranchwisePccReadingView(),
          //     Container()
          //   ],
          //   iconData1: Icons.content_paste,
          //   iconData2: Icons.calendar_month,
          //   iconData3: Icons.account_tree,
          // ),
        ),
      ),
    );
  }
}
