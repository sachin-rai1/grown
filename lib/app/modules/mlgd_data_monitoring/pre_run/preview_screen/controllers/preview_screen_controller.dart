import 'dart:developer';
import 'dart:io';
import 'package:grown/app/data/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreviewScreenController extends GetxController {

  File? imageFile;
  final runNoController = TextEditingController();
  var myStatus = 0.obs;
  dynamic argumentData = Get.arguments;
  var isRunNoLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    log(argumentData[0]["imageFile"].toString());
    imageFile = argumentData[0]["imageFile"];
    currentImgPath.value = imageFile!.path;
  }

  Future<void> getRunNo({required int runNo}) async {
    try{
      isRunNoLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(Uri.parse("$apiUrl/view_run_no?run_id=$runNo") , headers: {
        'Authorization':'Bearer $token'
      });
      if(response.statusCode ==200){
        myStatus.value = 200;
      }
      else{
        myStatus.value = 404;
      }
    }
    catch(e){
      log("$e");
    }
    finally{
      isRunNoLoading.value = false;
    }
  }

  List items = [
    'Please wait while we upload',
    'We know your time is important , but you have to wait',
    'Have a coffee/tea while we upload',
    "Your file is being securely uploaded. Thank you for your patience.",
    "Just a few more moments while your file is uploaded.",
    "Hang tight! We're almost done uploading your file.",
    "Your file is important to us. We appreciate your patience as it uploads.",
    "Uploading files can take a little while. We'll let you know as soon as it's done.",
    "The file is  uploading. Thanks for waiting!",
    "We're working on uploading your file as quickly as possible. Please bear with us.",
    "Your file is uploading. This might take a few moments, so please don't close the window.",
    "Uploading large files can take a while. We're doing our best to make it as quick as possible.",
    "Your file is on its way to our server. Thanks for your patience while we get it there."
  ];

  List imageTypes = [
    {"id": "1", "type": "Plotting Image"},
    {"id": "2", "type": "Plasma Setted Image"},
  ];

  List plasmaImageSides = [
    {"id": "1", "type": "Top View Image"},
    {"id": "2", "type": "Front View Image"},
    {"id": "3", "type": "Right View Image"},
    {"id": "4", "type": "Left View Image"},
  ];
  var selectedImageType = 1.obs;
  var selectedPlasmaImageSides = 1.obs;
  var selectedPlottingImageSides = 1.obs;

  var isLoading = false.obs;
  dynamic responseStatus;
  dynamic randomItem;
  var currentImgPath = "".obs;
  dynamic data;



  upload(File img, int runNo) async {

    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      isLoading.value = true;
      randomItem = (items.toList()..shuffle()).first; //for waiting message

      var uploadURL = "$apiUrl/add_pre_run_data";
      var uri = Uri.parse(uploadURL);
      var request = http.MultipartRequest("POST", uri);
      request.headers.addAll({'Authorization': 'Bearer $token'});
      request.fields['run_no_fk'] = runNoController.text;
      request.fields['image_type'] = selectedImageType.toString();
      request.fields['image_side'] = selectedPlottingImageSides.toString();
      request.files.add(await http.MultipartFile.fromPath('image', img.path, filename: (img.path)));
      var response = await request.send();


      if (response.statusCode == 200) {
        showToast(msg: "Data Uploaded Successfully");
        runNoController.clear();
        selectedPlottingImageSides.value = 1;
        selectedImageType.value = 1;
        currentImgPath.value = "";
        myStatus.value = 0;
      } else if (responseStatus == 502) {
        showToastError(msg: "No Internet Connection",);
      } else {
        isLoading.value = false;
      }
    } finally {
        isLoading.value = false;
    }
  }



}