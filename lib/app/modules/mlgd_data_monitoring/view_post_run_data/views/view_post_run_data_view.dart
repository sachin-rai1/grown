import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../../pre_run/pre_run_view_data/controllers/pre_run_view_data_controller.dart';
import '../controllers/view_post_run_data_controller.dart';

class ViewPostRunDataView extends GetView<ViewPostRunDataController> {
  ViewPostRunDataView({Key? key}) : super(key: key);

  final viewPostRunDataController = Get.put(ViewPostRunDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: controller.postRunDataList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Card(
                  color: Colors.cyanAccent.shade100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        MyTextWidget(title: "Run No", body: controller.postRunDataList[index].runNoFk!.toString(),),
                        MyTextWidget(title: "Final Height", body: controller.postRunDataList[index].finalHeight!.toStringAsFixed(2),),
                        MyTextWidget(title: "New Growth Height", body: controller.postRunDataList[index].newGrowthHeight!.toStringAsFixed(2),),
                        MyTextWidget(title: "Average Growth Height", body: controller.postRunDataList[index].averageGrowthHeight!.toStringAsFixed(2),),
                        MyTextWidget(title: "Objective", body: controller.postRunDataList[index].objective,),
                        MyTextWidget(title: "Final Weight", body: controller.postRunDataList[index].finalWeight!.toStringAsFixed(2),),
                        MyTextWidget(title: "New Growth Weight", body: controller.postRunDataList[index].newGrowthWeight!.toStringAsFixed(2),),
                        MyTextWidget(title: "Clarity On New Growth ", body: controller.postRunDataList[index].clarityOnGrowth!.toStringAsFixed(2),),
                        MyTextWidget(title: "Total Duration", body: controller.postRunDataList[index].runningHours!.toStringAsFixed(2),),
                        MyTextWidget(title: "Production/Hour", body: controller.postRunDataList[index].productionPerHour!.toStringAsFixed(2),),
                        MyTextWidget(title: "Area Cover", body: controller.postRunDataList[index].totalPcsArea!.toStringAsFixed(2),),
                        MyTextWidget(title: "Shut Down Reason", body: controller.postRunDataList[index].shutDownReason.toString(),),
                        MyTextWidget(title: "Remarks", body: controller.postRunDataList[index].remarks!.toString(),),
                        MyTextWidget(title: "Created On", body: controller.postRunDataList[index].runNoCreated!.toString(),),
                        MyTextWidget(title: "Finished On", body: controller.postRunDataList[index].createdOn!.toString(),),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(onPressed: () {
                                controller.getPreRunData(runNO: int.parse(controller.postRunDataList[index].runNo!.toString()));
                                viewPreRunData(context: context);
                              },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange
                                ), child: const Text("View Pre Run Data"),
                              ),
                              ElevatedButton(onPressed: () {
                                    controller.getRunningData(runNO: int.parse(controller.postRunDataList[index].runNo!.toString()));
                                    viewRunningData(context: context);
                              },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber
                                ), child: const Text("View Running Data"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
    );
  }

  void viewPreRunData({required BuildContext context}) {
    showBottomSheet(context: context, builder: (context) {
      return Obx(() {

        return (controller.isPreRunDataLoading.value == true)?const Center(child: CircularProgressIndicator(),) :(controller.preRunDataList.isEmpty)
            ? const Center(
            child: Text(
                "No Data found "))
            :  ListView.builder(
            itemCount: controller.preRunDataList.length,
            itemBuilder: (context, index) {
              var imageType = "";
              var imageSide = "";

              switch (
              controller.preRunDataList[index].imageType) {
                case 1:
                  {
                    imageType = "Plotting Image";
                    break;
                  }
                case 2:
                  {
                    imageType = "Plasma Setted Image";
                    break;
                  }
              }
              switch (
              controller.preRunDataList[index].imageSide) {
                case 1:
                  {
                    imageSide = "Top View Image";
                    break;
                  }
                case 2:
                  {
                    imageSide = "Front View Image";
                    break;
                  }
                case 3:
                  {
                    imageSide = "Right View Image";
                    break;
                  }
                case 4:
                  {
                    imageSide = "Left View Image";
                    break;
                  }
              }
              return Obx(
                    () => Card(
                  color: Colors.indigo.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        MyTextWidget(
                          title: "Run No : ",
                          body:
                          "${controller.preRunDataList[index].runNoFk}",
                          isLines: false,
                        ),
                        MyTextWidget(
                          title: "Date : ",
                          body:
                          "${controller.preRunDataList[index].createdOn}",
                          isLines: false,
                        ),
                        MyTextWidget(
                          title: "Image Type : ",
                          body: imageType,
                          isLines: false,
                        ),
                        MyTextWidget(
                          title: "Image Side : ",
                          body: imageSide,
                          isLines: false,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 3),
                          child: Image.network(controller
                              .preRunDataList[index]
                              .image!),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      });
    });
  }

  void viewRunningData({required BuildContext context}) {
    showBottomSheet(context: context, builder: (context){
    return Obx(
          () =>(controller.isRunningDataLoading.value == true)?const Center(child: CircularProgressIndicator()): (controller.mlgdDataList.isEmpty == true)
          ?  Center(
          child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height/1.5,
              child: const Text("No Data Found" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),)))
          : ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.mlgdDataList.length,
          itemBuilder: (BuildContext context, index) {
            dynamic cleanPer = controller.mlgdDataList[index].cleanPcsNo! / controller.mlgdDataList[index].totalPcsNo! * 100;
            var topView = controller.mlgdDataList[index].topView;
            var frontView = controller.mlgdDataList[index].frontView;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5),
              child: Card(
                color: Colors.pink.shade50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            InkWell(onTap: (){

                            }, child: const Icon(Icons.edit_note_outlined , size: 35,color: Colors.deepPurpleAccent,)),
                            const SizedBox(width: 20,),
                            InkWell(onTap: (){

                            }, child: const Icon(Icons.delete_forever_sharp , size: 30, color: Colors.red,)),
                          ],
                        ),
                      ),
                      MyTextWidget(
                        title: "Date : " , body: controller.mlgdDataList[index].createdOn.toString(),
                      ),
                      Container(
                          width:
                          MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.grey.withOpacity(0.5)),
                      MyTextWidget(title: "Run No : " , body: controller.mlgdDataList[index].runNo.toString(),),
                      MyTextWidget(title: "Clean % : " , body: " ${num.parse(cleanPer.toString()).toStringAsFixed(2)} %",),
                      MyTextWidget(title: "Holder Size : " , body: controller.mlgdDataList[index].holderSize.toString(),),
                      MyTextWidget(title: "Running Hours : " , body: controller.mlgdDataList[index].runningHours.toString(),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyTextWidget(isLines: false, title: "X : " , body: controller.mlgdDataList[index].x.toString(),),
                          MyTextWidget(isLines: false, title: "Y : " , body: controller.mlgdDataList[index].y.toString(),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyTextWidget(isLines: false, title: "Z : " , body: controller.mlgdDataList[index].z.toString(),),
                          MyTextWidget(isLines: false, title: "T : " , body: controller.mlgdDataList[index].t.toString(),),
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(bottom: 10),
                        child: Container(
                            width:
                            MediaQuery.of(context).size.width,
                            height: 1,
                            color: Colors.grey.withOpacity(0.5)),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text("Front View "),
                              GestureDetector(
                                onTap: (){
                                  enlargeImage(frontView, context);
                                  FocusScope.of(context).unfocus();
                                },
                                child: Image.network(
                                  frontView!,
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Top View"),
                              GestureDetector(
                                onTap: (){
                                  enlargeImage(topView, context);
                                  FocusScope.of(context).unfocus();

                                },
                                child: Image.network(
                                  topView!,
                                  height: 100,
                                  width: 100,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
    });
  }

  void enlargeImage(data,BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Image.network(data),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }


}
