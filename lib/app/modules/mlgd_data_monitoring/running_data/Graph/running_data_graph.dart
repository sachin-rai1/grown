import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Model/model_mlgd_data.dart';
import '../view_running_data_run_wise/controllers/view_mlgd_data_run_wise_controller.dart';
class RunningDataGraph extends GetView<ViewMlgdDataRunWiseController> {
   RunningDataGraph({Key? key}) : super(key: key);
   final viewMlgdDataRunWiseController = Get.put(ViewMlgdDataRunWiseController());
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Run No : " ,style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.w600),),
                TextFormField(
                  controller:controller.runController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter Run No",
                      contentPadding: const EdgeInsets.only(left: 10),
                      constraints: BoxConstraints(maxHeight: 40, maxWidth: w / 2),
                      border: const OutlineInputBorder()),
                ),
                IconButton(onPressed:() {
                  controller.getData(controller.runController.text);

                }, icon: const Icon(Icons.search),
                  color: Colors.teal,
                  iconSize: w * 0.1,)
              ],
            ),

            Expanded(
              child: Obx(() {
                return (controller.isLoading.value == true)?
                const Center(child: CircularProgressIndicator(),):
                SfCartesianChart(
                  enableAxisAnimation: true,
                  tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: true),
                  crosshairBehavior: CrosshairBehavior(enable: true),
                  enableMultiSelection: true,
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    zoomMode: ZoomMode.xy,
                  ),
                  backgroundColor: Colors.white,
                  legend: Legend(
                    isVisible: true,
                    borderWidth: 2,
                    position: LegendPosition.top,
                    isResponsive: true,
                  ),
                  primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Time'), ),
                  primaryYAxis: NumericAxis(title: AxisTitle(text: 'X')),
                  series: [
                    LineSeries<MlgdData, dynamic>(
                      name: "X",
                      dataSource: controller.mlgdDataList,
                      xValueMapper: (MlgdData dataProcess, _) => controller.changeDateTimeFormat(dataProcess.createdOn!),
                      yValueMapper: (MlgdData dataProcess, _) => dataProcess.x! / 100,
                    ),
                    LineSeries<MlgdData, dynamic>(
                      name: 'Y',
                      dataSource: controller.mlgdDataList,
                      xValueMapper: (MlgdData dataProcess, _) =>
                          controller.changeDateTimeFormat(dataProcess.createdOn!),
                      yValueMapper: (MlgdData dataProcess, _) => dataProcess.y,
                    ),
                    LineSeries<MlgdData, dynamic>(
                      name: 'Z',
                      dataSource: controller.mlgdDataList,
                      xValueMapper: (MlgdData dataProcess, _) =>
                          controller.changeDateTimeFormat(dataProcess.createdOn!),
                      yValueMapper: (MlgdData dataProcess, _) => dataProcess.z,
                    ),
                    LineSeries<MlgdData, dynamic>(
                      name: 'T',
                      dataSource: controller.mlgdDataList,
                      xValueMapper: (MlgdData dataProcess, _) =>
                          controller.changeDateTimeFormat(dataProcess.createdOn!),
                      yValueMapper: (MlgdData dataProcess, _) => dataProcess.t,
                    ),
                    LineSeries<MlgdData, dynamic>(
                      name: 'Clean %',
                      dataSource: controller.mlgdDataList,
                      xValueMapper: (MlgdData dataProcess, _) =>
                          controller.changeDateTimeFormat(dataProcess.createdOn!),
                      yValueMapper: (MlgdData dataProcess, _) =>
                      dataProcess.cleanPcsNo! / dataProcess.totalPcsNo! * 100,
                    ),
                  ],
                );

              }),
            )
          ],
        ),
      ),
    );
  }
}