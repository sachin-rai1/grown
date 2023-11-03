import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/preview_screen_controller.dart';

class PreviewScreenView extends GetView<PreviewScreenController> {
  PreviewScreenView({Key? key}) : super(key: key);
  final previewScreenController = Get.put(PreviewScreenController());
  // final cameraScreenController = Get.put(CameraScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Get.back();
              // cameraScreenController.isCameraInitialized.value = false;
              // cameraScreenController.onNewCameraSelected(cameraScreenController.cameras[1]);

            },
            child: const Icon(
              Icons.arrow_back,
              size: 35,
              semanticLabel: "back",
            )),
        title: const Text(
          "Camera Preview",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Obx(()=>
        (controller.currentImgPath.value == "")
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Your Image Uploaded Successfully",
                    style: TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("Go back to Camera"))
                ],
              ))
            : Obx(() => (controller.isLoading.value == true)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.blue,
                          child: Text(
                            controller.randomItem,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(splashColor: Colors.blue),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  keyboardAppearance: Brightness.dark,
                                  controller: controller.runNoController,
                                  onChanged: (string) {
                                    controller.getRunNo(runNo:controller.runNoController.text == ""?0: int.parse(controller.runNoController.text));
                                  },
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      hintText: "Enter Run No : ",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: BoxConstraints(
                                          maxHeight: 40,
                                          maxWidth:
                                              MediaQuery.of(context).size.width /
                                                  2)),
                                ),
                              ),
                            ),
                            Obx(()=>controller.isRunNoLoading.value == true?const Center(child: CircularProgressIndicator()):
                               (controller.myStatus.value == 200)
                                  ? const Icon(
                                      Icons.done_outlined,
                                      color: Colors.green,
                                      size: 35,
                                    )
                                  : const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButtonFormField(
                              value: "Plotting Image",
                              decoration: InputDecoration(
                                  label: const Text("Image Type"),
                                  contentPadding:
                                      const EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(
                                      maxHeight: 45,
                                      maxWidth:
                                          MediaQuery.of(context).size.width),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              items: controller.imageTypes.map((e) {
                                return DropdownMenuItem<String>(
                                  onTap: () {
                                    controller.selectedImageType.value = int.parse(e["id"]);
                                    log(controller.selectedImageType.value.toString());

                                  },
                                  value: e["type"],
                                  child: Text(e["type"].toString()),
                                );
                              }).toList(),
                              onChanged: (changed) {}),
                        ),

                        controller.selectedImageType.value == 1?
                        Container():
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: DropdownButtonFormField(
                              value: "Top View Image",
                              decoration: InputDecoration(
                                  label: const Text("Image Type"),
                                  contentPadding:
                                  const EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(
                                      maxHeight: 45,
                                      maxWidth:
                                      MediaQuery.of(context).size.width),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              items: controller.plasmaImageSides.map((e) {
                                return DropdownMenuItem<String>(
                                  onTap: () {
                                    controller.selectedPlasmaImageSides.value = int.parse(e["id"]);
                                    log(controller.selectedPlasmaImageSides.value.toString());
                                  },
                                  value: e["type"],
                                  child: Text(e["type"].toString()),
                                );
                              }).toList(),
                              onChanged: (changed) {}),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Image.file(
                            alignment: Alignment.topLeft,
                            controller.imageFile!,
                            fit: BoxFit.cover,
                            // height: MediaQuery.of(context).size.height / 1.5,
                            // width: MediaQuery.of(context).size.width
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  // cameraScreenController.isCameraInitialized.value = false;
                                  // cameraScreenController.onNewCameraSelected(cameraScreenController.cameras[1]);
                                  Get.back();
                                },
                                color: Colors.red,
                                shape: const CircleBorder(),
                                height: 50,
                                child: const Icon(
                                  Icons.cancel,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  if (controller.myStatus.value == 200) {
                                    controller.upload(
                                        controller.imageFile!,
                                        int.parse(
                                            controller.runNoController.text));
                                  } else {
                                    Get.showSnackbar(const GetSnackBar(
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.red,
                                      title: "Wrong Run No ",
                                      message:
                                          "Run No should be unique and  min. 6 digit",
                                      duration: Duration(milliseconds: 2000),
                                    ));
                                  }
                                },
                                color: Colors.green,
                                shape: const CircleBorder(),
                                height: 50,
                                child: const Icon(
                                  Icons.done_outlined,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
