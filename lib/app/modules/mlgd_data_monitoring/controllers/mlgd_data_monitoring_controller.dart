import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

import '../../../data/constants.dart';

class MlgdDataMonitoringController extends GetxController {

  final runNoController = TextEditingController();
  final runningHoursController = TextEditingController();

  final totalPcsNoController = TextEditingController();
  final totalPcsAreaController = TextEditingController();
  final bigPcsNoController = TextEditingController();
  final regularPcsNumberController = TextEditingController();

  final cleanPcsController = TextEditingController();
  final breakagePcsController = TextEditingController();
  final dotPcsController = TextEditingController();
  final inclusionPcsController = TextEditingController();

  final xController = TextEditingController();
  final yController = TextEditingController();
  final zController = TextEditingController();
  final tController = TextEditingController();
  final operatorNameController = TextEditingController();
  final passController = TextEditingController();

  var size = ''.obs;
  File? _image;
  File? _image2;
  dynamic bytes1;
  dynamic bytes2;
  dynamic total;
  dynamic totalPcs;
  final formKey = GlobalKey<FormState>();
  var loading = false.obs;
  Rx<File?> resizedFrontImageFile = Rx<File?>(null);
  Rx<File?> resizedTopImageFile = Rx<File?>(null);
  CroppedFile? croppedFile;
  void checkSum() {
    total = int.tryParse(cleanPcsController.text) ?? 0;
    total += int.tryParse(breakagePcsController.text) ?? 0;
    total += int.tryParse(dotPcsController.text) ?? 0;
    total += int.tryParse(inclusionPcsController.text) ?? 0;

    totalPcs = int.tryParse(totalPcsNoController.text) ?? 0;
    if (total > totalPcs) {
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        title: "Total No of Pcs exceeded",
        message: "Total Pcs = $totalPcs and BCDI = $total",
        duration: const Duration(seconds: 5),
      ));
    } else if (total < totalPcs) {
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        title: "Wrong Entry ",
        message: "Total Pcs = $totalPcs and BCDI = $total",
        duration: const Duration(seconds: 5),
      ));
    } else if (_image == null || _image2 == null) {
      Get.showSnackbar(const GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        title: "Null Image ",
        message: "Image should not be empty",
        duration: Duration(seconds: 2),
      ));
    } else if (size.value == "") {
      Get.showSnackbar(const GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        title: "Holder Size Empty ",
        message: "Please Select a Holder Size",
        duration: Duration(seconds: 2),
      ));
    } else {
      postData(resizedFrontImageFile.value! , resizedTopImageFile.value!);
    }
  }

  void clearData() {
    runNoController.clear();
    runningHoursController.clear();
    totalPcsNoController.clear();
    totalPcsAreaController.clear();
    bigPcsNoController.clear();
    regularPcsNumberController.clear();
    cleanPcsController.clear();
    breakagePcsController.clear();
    dotPcsController.clear();
    inclusionPcsController.clear();
    xController.clear();
    yController.clear();
    zController.clear();
    tController.clear();
    operatorNameController.clear();
    size.value = "";
    _image = null;
    _image2 = null;
    resizedFrontImageFile.value = null;
    resizedTopImageFile.value = null;

  }

  Future<void> postData(File frontImage, File topImage) async {
    loading.value = true;
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var uploadUrl = '$apiUrl/add_mlgd_data';
    var uri = Uri.parse(uploadUrl);
    var request = http.MultipartRequest("POST", uri);
    request.headers.addAll({'Authorization': 'Bearer $token'});
    request.files.add(await http.MultipartFile.fromPath('frontView', frontImage.path, filename: (frontImage.path)));
    request.files.add(await http.MultipartFile.fromPath('topView', topImage.path, filename: (topImage.path)));
    request.fields["runNo"] = runNoController.text.toString();
    request.fields["runningHours"] = runningHoursController.text.toString();
    request.fields["holderSize"] = size.value;
    request.fields["totalPcsNo"] = totalPcsNoController.text.toString();
    request.fields["totalPcsArea"] = totalPcsAreaController.text.toString();
    request.fields["bigPcsNo"] = bigPcsNoController.text.toString();
    request.fields["regularPcsNo"] = regularPcsNumberController.text.toString();
    request.fields["cleanPcsNo"] = cleanPcsController.text.toString();
    request.fields["breakagePcs"] = breakagePcsController.text.toString();
    request.fields["dotPcs"] = dotPcsController.text.toString();
    request.fields["inclusionPcs"] = inclusionPcsController.text.toString();
    request.fields["x"] = xController.text.toString();
    request.fields["y"] = yController.text.toString();
    request.fields["z"] = zController.text.toString();
    request.fields["t"] = tController.text.toString();
    request.fields["operatorName"] = operatorNameController.text.toString();
    // Send the request
    var response = await request.send();
    if (response.statusCode == 200) {
      Get.showSnackbar(const GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        title: "Success",
        message: "Data Inserted Successfully",
        duration: Duration(seconds: 2),
      ));
      clearData();
      loading.value = false;
    } else {
      print(response.stream);
      loading.value = false;
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        title: "Error : ${response.statusCode}",
        message: "error",
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<File> _cropFrontImage(File image) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
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
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    final bytes = await croppedFile?.readAsBytes();
    final resizedImage = img.decodeImage(bytes!);
    final resized = img.copyResize(resizedImage!, width: 512, height: 512);
    final tempDir = await getTemporaryDirectory();

    return File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpeg')..writeAsBytesSync(img.encodeJpg(resized));

  }
  _cropTopImage(File image) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
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
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),

      ],
    );
    final bytes = await croppedFile?.readAsBytes();
    final resizedImage = img.decodeImage(bytes!);
    final resized = img.copyResize(resizedImage!, width: 512, height: 512);
    final tempDir = await getTemporaryDirectory();
    resizedTopImageFile.value =  File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpeg')..writeAsBytesSync(img.encodeJpg(resized));
  }

  Future<void> uploadTopPhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    _image2 = File(image!.path);
    _cropTopImage(_image2!);

  }

  Future<void> uploadTopPhotoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    _image2 = File(image!.path);
    _cropTopImage(_image2!);
  }

  Future<void> uploadFrontPhotoFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    // bytes1 = await _image?.readAsBytes();
    // print(bytes1);
      _image = File(image!.path);
      _cropFrontImage(_image!);


  }

  Future<void> uploadFrontPhotoFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    _image = File(image!.path);
    var abc = await _cropFrontImage(_image!);
    resizedFrontImageFile.value = abc;
  }

}
