import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/camera_application_controller.dart';

class CameraApplicationView extends GetView<CameraApplicationController> {
   CameraApplicationView({Key? key}) : super(key: key);
  final cameraApplicationController = Get.put(CameraApplicationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CameraApplicationView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CameraApplicationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
