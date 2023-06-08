import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../data/widgets.dart';
import '../controllers/register_complain_controller.dart';

class RegisterComplainView extends GetView<RegisterComplainController> {
  RegisterComplainView({Key? key}) : super(key: key);
  final registerComplainController = Get.put(RegisterComplainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register Complain'),
          centerTitle: true,
        ),
        body: Obx(() {
          return (controller.isLoading.value == true)?const Center(child: CircularProgressIndicator()): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return MyTextWidget(
                      title: "Ticket No : ",
                      body: controller.ticketNo.value,
                      isLines: false,
                    );
                  }),
                  TextFormWidget(
                    textController: controller.machineNameController,
                    dropDown: false,
                    titleText: 'Machine Name',
                  ),
                  TextFormWidget(
                    textController: controller.machineNoController,
                    dropDown: false,
                    titleText: 'Machine No',
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Problems :  ",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                          () =>
                      (controller.isLoading.value == true)
                          ? const Center(child: CircularProgressIndicator())
                          : (controller.problemsDataList.isEmpty)
                          ? const Center(
                        child: Text("No Problems Defined Yet"),
                      )
                          : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.problemsDataList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return CheckboxListTile(
                                // subtitle: Text(controller.isCheckedList[index].toString()),
                                controlAffinity:
                                ListTileControlAffinity.leading,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                enableFeedback: true,
                                title: Text(
                                  controller.problemsDataList[index].description!,
                                ),
                                value: controller.isCheckedList[index],
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  controller.isCheckedList[index] =
                                  value!;
                                  if (controller.isCheckedList[index] ==
                                      true) {
                                    controller.problem.add(controller
                                        .problemsDataList[index]
                                        .description!);
                                  }
                                  if (controller.isCheckedList[index] ==
                                      false) {
                                    controller.problem.remove(controller
                                        .problemsDataList[index]
                                        .description!);
                                  }
                                  print(controller.problem.join(","));
                                },
                              );
                            });
                          }),
                    ),
                  ),
                  TextFormWidget(
                    hintText: "Descriptions",
                    textController: controller.descriptionController,
                    dropDown: false,
                    titleText: 'Problems Description (If Any)',
                    maxLines: 20,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                  ),
                  Obx(
                        () =>
                    (controller.selectedImages.isEmpty)
                        ? Container()
                        : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: controller.selectedImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(context: context, builder: (context){
                              return PhotoView(imageProvider: FileImage(File(controller.selectedImages[index].path)));
                            });
                          },
                          child: Stack(
                            children: [
                              Image.file(
                                  File(controller
                                      .selectedImages[index].path),
                                  fit: BoxFit.cover,
                                  height: 155,
                                  width: 165),
                              Positioned(
                                top: 0,
                                right: 10,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Color(0xff96030c),
                                    size: 35,
                                  ),
                                  onPressed: () =>
                                      controller.removeImage(index),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.photo),
                          iconSize: 80,
                          onPressed: () {
                            controller.pickMyMultiImage();
                          },
                        ),
                        const SizedBox(width: 35),
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          iconSize: 80,
                          onPressed: () => controller.pickImageFromCamera(),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.insertData();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        fixedSize: Size(MediaQuery
                            .of(context)
                            .size
                            .width, 20)),
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
