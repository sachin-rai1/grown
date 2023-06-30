import 'package:flutter/material.dart';

import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../data/widgets.dart';
import '../controllers/search_by_serial_no_controller.dart';

class SearchBySerialNoView extends GetView<SearchBySerialNoController> {
   SearchBySerialNoView({Key? key}) : super(key: key);
  final searchBySerialNoController = Get.put(SearchBySerialNoController());
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Serial No Wise Data'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  TextFormWidget(dropDown: false, titleText: "Serial No" , textBoxWidth: w / 1.8 , textController: controller.serialNoController,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(onPressed: ()=>controller.fetchDataBySerialNo(controller.serialNoController.text), child: const Text("Search")),
                  ),
                ],
              ),
              Expanded(child: viewOnlineGases(context)),
            ],
          ),
        )
    );
  }
  Widget viewOnlineGases(BuildContext context){
    return Obx(
          () => (controller.dataBySerialNo.isEmpty)
          ? Container()
          : ListView.builder(
          itemCount: controller.dataBySerialNo.length,
          itemBuilder: (context, index) {
            var startingDate = DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(controller
                .dataBySerialNo[index].startingOn
                .toString()));
            var dueDate = DateFormat("dd-MM-yyyy").format(
                DateTime.parse(controller
                    .dataBySerialNo[index].dueDate
                    .toString()));
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,),
                child: Column(
                  children: [
                    MyTextWidget(
                      title: "Status",
                      body:  controller.dataBySerialNo[index].statusName.toString(),
                    ),
                    MyTextWidget(
                      title: "Started On",
                      body: startingDate,
                    ),
                    MyTextWidget(
                      title: "Serial No",
                      body: controller
                          .dataBySerialNo[index]
                          .serialNo
                          .toString(),
                    ),
                    MyTextWidget(
                      title: "Total Qty",
                      body: controller
                          .dataBySerialNo[index].gasQty
                          .toString(),
                    ),

                    MyTextWidget(
                      title: "Consumption",
                      body: "${controller.dataBySerialNo[index].consumption.toString()} bars/day",
                    ),

                    MyTextWidget(
                      title: "Last Date",
                      body: dueDate,
                    ),
                    MyTextWidget(
                      title: "Operator Name",
                      body: controller.dataBySerialNo[index].operatorName,
                    ),
                  ],
                ),
              ),
            );
          }),
    );

  }
}
