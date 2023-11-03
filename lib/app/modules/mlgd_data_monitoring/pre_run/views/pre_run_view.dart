import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/camera_screen/views/camera_screen_view.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/pre_run_controller.dart';
import '../pre_run_view_data/views/pre_run_view_data_view.dart';

class PreRunView extends GetView<PreRunController> {
   PreRunView({Key? key}) : super(key: key);

  final preRunController = Get.put(PreRunController());
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),

                  height: height / 4,
                  minWidth: width,
                  onPressed: () {
                    Get.to(()=>  CameraScreenView() , arguments: [{"cameras" : controller.cameras}]);
                  },
                  elevation: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Icon(Icons.camera_alt_outlined , size: height*0.1,),
                      const Text("Camera Upload"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                    height: height / 4,
                    minWidth: width,
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      File imageFile = File(image!.path);
                      controller.cropImage(imageFile);
                    },
                    child: Column(
                      children:  [
                        Icon(Icons.photo , size: height*0.1),
                        const Text("Gallery Upload"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: height / 4,
                    minWidth: width,
                    onPressed: () {
                      Get.to(()=>  PreRunViewDataView());
                    },
                    child: Column(
                      children:  [
                        Icon(Icons.folder , size: height*0.1),
                        const Text("Pre-Run Report"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}