import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/pre_run_view_data/views/pre_run_view_data_view.dart';
import 'package:path_provider/path_provider.dart';
import '../controllers/camera_screen_controller.dart';


class CameraScreenView extends GetView<CameraScreenController> {
  CameraScreenView({Key? key}) : super(key: key);
  final cameraScreenController = Get.put(CameraScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
            backgroundColor: Colors.black,
            body: controller.isCameraPermissionGranted.value == true
                ? controller.isCameraInitialized.value == true ?
            controller.isCropperLoading.value == true ? const Center(
                child: CircularProgressIndicator())
                : Column(
              children: [
                Obx(() {
                  return AspectRatio(
                    aspectRatio: 1 /
                        controller.cameraController!.value.aspectRatio,
                    child: Stack(
                      children: [
                        CameraPreview(
                          controller.cameraController!,
                          child: LayoutBuilder(builder:
                              (BuildContext context,
                              BoxConstraints constraints) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTapDown: (details) =>
                                  controller.onViewFinderTap(
                                      details, constraints),
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            8.0,
                            16.0,
                            8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, top: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${controller.currentExposureOffset
                                          .toStringAsFixed(1)}x',
                                      style: const TextStyle(
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: SizedBox(
                                    height: 30,
                                    child: Slider(
                                      value: controller.currentExposureOffset
                                          .value,
                                      min: controller.minAvailableExposureOffset
                                          .value,
                                      max: controller.maxAvailableExposureOffset
                                          .value,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        controller.currentExposureOffset.value =
                                            value;
                                        await controller.cameraController!
                                            .setExposureOffset(value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Slider(
                                      value: controller.currentZoomLevel.value,
                                      min: controller.minAvailableZoom.value,
                                      max: controller.maxAvailableZoom.value,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white30,
                                      onChanged: (value) async {
                                        controller.currentZoomLevel.value =
                                            value;

                                        await controller.cameraController!
                                            .setZoomLevel(value);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black87,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${controller.currentZoomLevel
                                              .toStringAsFixed(1)}x',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      controller.isCameraInitialized.value =
                                      false;
                                      controller.onNewCameraSelected(
                                          controller.cameras[controller
                                              .isRearCameraSelected.value
                                              ? 1
                                              : 0]);
                                      controller.isRearCameraSelected.value =
                                      !controller.isRearCameraSelected.value;
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.black38,
                                          size: 60,
                                        ),
                                        Icon(
                                          controller.isRearCameraSelected.value
                                              ? Icons.camera_front
                                              : Icons.camera_rear,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      try {
                                        controller.isCropperLoading.value =
                                        true;
                                        XFile? rawImage = await controller.takePicture();
                                        File imageFile = File(rawImage!.path);
                                        int currentUnix = DateTime.now().millisecondsSinceEpoch;
                                        final directory = await getApplicationDocumentsDirectory();
                                        String fileFormat = imageFile.path.split('.').last;
                                        await imageFile.copy('${directory
                                            .path}/$currentUnix.$fileFormat',);
                                        controller.cropImage(imageFile);
                                      }
                                      catch (e) {
                                        showToastError(msg: "$e");
                                      }
                                      finally {
                                        controller.isCropperLoading.value = false;
                                      }
                                    },
                                    child: const Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.white,
                                          size: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => PreRunViewDataView());
                                    },
                                    child: Icon(
                                      CupertinoIcons.folder_fill,
                                      size: 60,
                                      color: Colors.blue.shade100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              16.0, 8.0, 16.0, 8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [

                              InkWell(
                                  onTap: () async {
                                    controller.currentFlashMode.value =
                                        FlashMode.off;
                                    await controller.cameraController!
                                        .setFlashMode(FlashMode.off,
                                    );
                                  },
                                  child: Icon(Icons.flash_off,
                                    color: controller.currentFlashMode.value == FlashMode.off ? Colors
                                        .amber : Colors.white,
                                  )

                              ),
                              InkWell(
                                onTap: () async {
                                  controller.currentFlashMode.value =
                                      FlashMode.auto;

                                  await controller.cameraController!
                                      .setFlashMode(
                                    FlashMode.auto,
                                  );
                                },
                                child: Icon(
                                  Icons.flash_auto,
                                  color:
                                  controller.currentFlashMode.value ==
                                      FlashMode.auto
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.currentFlashMode.value =
                                      FlashMode.always;

                                  await controller.cameraController!
                                      .setFlashMode(
                                    FlashMode.always,
                                  );
                                },
                                child: Icon(
                                  Icons.flash_on,
                                  color: controller.currentFlashMode.value ==
                                      FlashMode.always
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  controller.currentFlashMode.value =
                                      FlashMode.torch;

                                  await controller.cameraController!
                                      .setFlashMode(
                                    FlashMode.torch,
                                  );
                                },
                                child: Icon(
                                  Icons.highlight,
                                  color:
                                  controller.currentFlashMode.value ==
                                      FlashMode.torch
                                      ? Colors.amber
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
                : const Center(child: CircularProgressIndicator())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Row(),
                const Text(
                  'Permission denied',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    controller.getPermissionStatus();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Give permission',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            )
        );
      }),
    );
  }
}
