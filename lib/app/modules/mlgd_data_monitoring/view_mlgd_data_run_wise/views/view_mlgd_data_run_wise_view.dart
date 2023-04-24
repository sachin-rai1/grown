import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/widgets.dart';
import '../controllers/view_mlgd_data_run_wise_controller.dart';

class ViewMlgdDataRunWiseView extends GetView<ViewMlgdDataRunWiseController> {
   ViewMlgdDataRunWiseView({Key? key}) : super(key: key);
  final viewMlgdDataRunWiseController = Get.put(ViewMlgdDataRunWiseController());
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Run No : "),
                      TextFormField(
                        controller:controller.runController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: "Enter Run No",
                            contentPadding: const EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(maxHeight: 40, maxWidth: w / 2),
                            border: const OutlineInputBorder()),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.getData(controller.runController.text);

                        },
                        label: const Text("Search"),
                        icon: const Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
                Obx(
                      () => (controller.data.isEmpty)
                      ?  SizedBox(
                      height: Get.mediaQuery.size.height /1.5,
                      child: const Center(child: Text("Please Enter Valid Run No" , style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w500),)))
                      : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.data.length,
                      itemBuilder: (BuildContext context, index) {
                        dynamic cleanPer = controller.data[index]["cleanPcsNo"] / controller.data[index]["totalPcsNo"] * 100;
                        return (controller.runController.text.isEmpty)
                            ? Container():
                        Padding(
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
                                  MyTextWidget(
                                    title:
                                    "Date : " ,
                                    body: controller.data[index]["created_on"],
                                  ),
                                  Container(
                                      width:
                                      MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: Colors.grey.withOpacity(0.5)),
                                  MyTextWidget(title: "Run No : " , body: controller.data[index]["runNo"].toString(),),
                                  MyTextWidget(title: "Clean % : " , body: " ${num.parse(cleanPer.toString()).toStringAsFixed(2)} %",),
                                  MyTextWidget(title: "Holder Size : " , body: controller.data[index]["holderSize"].toString(),),
                                  MyTextWidget(title: "Running Hours : " , body: controller.data[index]["runningHours"].toString(),),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextWidget(isContainer: false, title: "X : " , body: controller.data[index]["x"].toString(),),
                                      MyTextWidget(isContainer: false, title: "Y : " , body: controller.data[index]["y"].toString(),),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyTextWidget(isContainer: false, title: "Z : " , body: controller.data[index]["z"].toString(),),
                                      MyTextWidget(isContainer: false, title: "T : " , body: controller.data[index]["t"].toString(),),
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
                                              enlargeImage(context , controller.data[index]["frontView"]);
                                              FocusScope.of(context).unfocus();
                                            },
                                            child: Image.network(
                                              controller.data[index]["frontView"],
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
                                              enlargeImage(context , controller.data[index]["topView"]);
                                              FocusScope.of(context).unfocus();
                                            },
                                            child: Image.network(
                                              controller.data[index]["topView"],
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
                ),
              ]),
        ));
  }
  void enlargeImage(BuildContext context, data) {
    AlertDialog alertDialog = AlertDialog(
      content: Image.network(data),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
}
