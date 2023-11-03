import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart'as img;
import 'package:path_provider/path_provider.dart';

import '../preview_screen/views/preview_screen_view.dart';

class PreRunController extends GetxController {
  final count = 0.obs;
  dynamic croppedFile;
  File? resizedFile;

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }

  var cameras = <CameraDescription>[].obs;

  Future<void> initCamera() async {
    try {
      final cameras = await availableCameras();
      this.cameras.value = cameras;
      log("Cameras : $cameras");
    } on CameraException catch (e) {
      log("No Camera Found");
      throw Exception(e);
    }
  }

  Future<void> cropImage(File imageFile) async {
    try {

      croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,

          ),
          IOSUiSettings(
            title: 'Cropper',
          ),

        ],
      );
      final bytes = await croppedFile?.readAsBytes();

      final resizedImage = img.decodeImage(bytes!);

      final resized = img.copyResize(resizedImage!, width: 512, height: 512);

      final tempDir = await getTemporaryDirectory();

      resizedFile = File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpg')..writeAsBytesSync(img.encodeJpg(resized));

      Get.to(()=>PreviewScreenView() , arguments: [{"imageFile" :resizedFile}]);

    }
    catch(e){
      log("$e");
    }
    finally{
      // isCropperLoading.value = false;
    }
  }
}
