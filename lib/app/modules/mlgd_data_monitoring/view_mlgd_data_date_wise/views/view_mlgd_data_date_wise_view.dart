import 'dart:developer';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/widgets.dart';
import '../controllers/view_mlgd_data_date_wise_controller.dart';

class ViewMlgdDataDateWiseView extends GetView<ViewMlgdDataDateWiseController> {
   ViewMlgdDataDateWiseView({Key? key}) : super(key: key);
  final viewMlgdDataDateWiseController =  Get.put(ViewMlgdDataDateWiseController());
  @override
  Widget build(BuildContext context) {

    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Select Date : ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Card(
                  elevation: 1,
                  color: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DateTimePicker(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      border: InputBorder.none,

                      constraints:
                      BoxConstraints(maxHeight: 45, maxWidth: w / 2.5),
                    ),
                    type: DateTimePickerType.date,
                    dateMask: 'dd/MM/yyyy',
                    initialValue: controller.selectedDate.value,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(Icons.event),
                    onChanged: (val) {
                      controller.selectedDate.value = val;
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');
                      controller.formatted = formatter.format(DateTime.parse(controller.selectedDate.value));
                     controller.getData(controller.formatted);

                    },
                    validator: (val) {
                      return null;
                    },
                    onSaved: (val) => log(val.toString()),
                  ),
                ),
              ],
            ),
          ),
          Obx(
                () =>(controller.isLoading.value == true)?const Center(child: CircularProgressIndicator()): (controller.data.isEmpty == true)
                ?  Center(
                child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height/1.5,
                    child: const Text("No Data Found" , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w500),)))
                : Expanded(
              child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (BuildContext context, index) {
                    dynamic cleanPer = controller.data[index]["cleanPcsNo"] / controller.data[index]["totalPcsNo"] * 100;
                    var topView = controller.data[index]['topView'];
                    var frontView = controller.data[index]['frontView'];
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          enlargeImage(frontView, context);
                                          FocusScope.of(context).unfocus();
                                        },
                                        child: Image.network(
                                          frontView,
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
                                          topView,
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
          ),
        ],
      ),
    );

  }
  void enlargeImage(data , BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      content: Image.network(data),
    );
    showDialog(context: context, builder: (context){
      return alertDialog;
    });
  }
}
