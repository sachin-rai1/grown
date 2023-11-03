import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/preview_screen/views/preview_screen_view.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart'as img;

class CameraScreenController extends FullLifeCycleController   {
  dynamic argumentData = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    cameras = argumentData[0]['cameras'];
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    getPermissionStatus();
  }

  CameraController? cameraController;
  late final List<CameraDescription> cameras;

  Rx<File>? imageFile;

  // Initial values
  RxBool isCameraInitialized = false.obs;
  RxBool isCameraPermissionGranted = false.obs;
  RxBool isRearCameraSelected = true.obs;

  var minAvailableExposureOffset = 0.0.obs;
  var maxAvailableExposureOffset = 0.0.obs;
  var minAvailableZoom = 1.0.obs;
  var maxAvailableZoom = 1.0.obs;
  //  Current values
  var currentZoomLevel = 1.0.obs;
  var currentExposureOffset = 0.0.obs;
  Rx<FlashMode> currentFlashMode = FlashMode.auto.obs;

  var allFileList = <File>[].obs;
  final resolutionPresets = ResolutionPreset.values;
  ResolutionPreset currentResolutionPreset = ResolutionPreset.high;
  dynamic croppedFile;
  File? resizedFile;

  Future<void> cropImage(File imageFile) async {
    try {
      isCropperLoading.value = true;
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
      // if(croppedFile == null){
      //   log("Hii");
      //   isCameraInitialized.value = false;
      //   onNewCameraSelected(cameras[1]);
      // }
      final bytes = await croppedFile?.readAsBytes();

      final resizedImage = img.decodeImage(bytes!);

      final resized = img.copyResize(resizedImage!, width: 512, height: 512);

      final tempDir = await getTemporaryDirectory();

      resizedFile = File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpg')..writeAsBytesSync(img.encodeJpg(resized));
      await refreshAlreadyCapturedImages();

    }
    catch(e){
        log("$e");
    }
    finally{
      isCropperLoading.value = false;
    }
  }

  getPermissionStatus() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    log(status.toString());
    if (status.isGranted) {
      log('Camera Permission: GRANTED');
        isCameraPermissionGranted.value = true;
      onNewCameraSelected(cameras[1]);
      // refreshAlreadyCapturedImages();
    } else {
      getPermissionStatus();
    }
  }

  var isCropperLoading = false.obs;

  refreshAlreadyCapturedImages() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> fileList = await directory.list().toList();
    allFileList.clear();
    List<Map<int, dynamic>> fileNames = [];

    for (var file in fileList) {
      if (file.path.contains('.jpg')) {
        allFileList.add(File(file.path));
        String name = file.path.split('/').last.split('.').first;
        fileNames.add({0: int.parse(name), 1: file.path.split('/').last});
      }
    }

    if (fileNames.isNotEmpty) {
      final recentFile = fileNames.reduce((curr, next) =>
      curr[0] > next[0]
          ? curr
          : next);
      String recentFileName = recentFile[1];
      imageFile?.value = File('${directory.path}/$recentFileName');

      Get.to(() => PreviewScreenView() , arguments: [{"imageFile" :resizedFile}]);
      log("recentFile");
      log(resizedFile.toString());
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? controller = cameraController;
    if (controller!.value.isTakingPicture) {
      return null;
    }

    try {
      final XFile file = await controller.takePicture();
      return file;
    } on CameraException catch (e) {
      log('Error occur while taking picture: $e');
      return null;
    }
  }

  void resetCameraValues() async {
    currentZoomLevel.value = 1.0;
    currentExposureOffset.value = 0.0;
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {

    final previousCameraController = cameraController;
    CameraController localCameraController = CameraController(
      cameraDescription,
      currentResolutionPreset,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await previousCameraController?.dispose();
    resetCameraValues();
    if(!isClosed){
      cameraController = localCameraController;
    }

    // Update UI if controller updated
    if(!isClosed) {
      localCameraController.addListener(() {});
    }

    try {
      await localCameraController.initialize();
      await Future.wait([
        localCameraController.getMinExposureOffset().then((value) => minAvailableExposureOffset.value = value),
        localCameraController.getMaxExposureOffset().then((value) => maxAvailableExposureOffset.value = value),
        localCameraController.getMaxZoomLevel().then((value) => maxAvailableZoom.value = value),
        localCameraController.getMinZoomLevel().then((value) => minAvailableZoom.value = value),
      ]);

      currentFlashMode.value = localCameraController.value.flashMode;
    } on CameraException catch (e) {
      log('Error initializing camera: $e');
    }

    if (!isClosed) {
        isCameraInitialized.value = localCameraController.value.isInitialized;
    }
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (cameraController == null) {
      return;
    }
    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController!.setExposurePoint(offset);
    cameraController!.setFocusPoint(offset);
  }
  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //
  //   super.didChangeAppLifecycleState(state);
  //   final CameraController? localCameraController = cameraController;
  //   // App state changed before we got the chance to initialize.
  //   if (localCameraController == null || !localCameraController.value.isInitialized) {
  //     return;
  //   }
  //
  //   if (state == AppLifecycleState.inactive) {
  //     localCameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     onNewCameraSelected(localCameraController.description);
  //   }
  //   else if(state == AppLifecycleState.paused){
  //     onNewCameraSelected(localCameraController.description);
  //   }
  //   log("Sate of App is : $state");
  // }
  //
  @override
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
  }
}
