import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../../../data/constants.dart';
import '../../../register_complain/Model/model_problems.dart';
import '../../Model/model_complains_view.dart';

class DateWiseComplainController extends GetxController {

  final ticketNoController = TextEditingController();
  final machineNameController = TextEditingController();
  final machineNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final problemsDataList = <ProblemsData>[].obs;
  List<String> newList = [];

  var isCheckedList = [].obs;
  List<String> problem = [];
  List<XFile> selectedImages = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();

  var selectedDate = DateTime.now().toString().obs;
  dynamic formatted;

  List<Map<String, dynamic>> jsonList = [];




  @override
  Future<void> onInit() async {
    super.onInit();
    var date =DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    selectedDate.value = formatted;
    await getComplains(selectedDate: selectedDate.value);
    await getPredefinedProblems();
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> pickImageFromCamera() async {
    if (selectedImages.length >= 5) {
      showToastError(msg: "Only 5 images are allowed");
    } else {
      XFile? image =
      await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (image != null) {
        selectedImages.add(image);
      }
    }
  }

  Future<void> pickMyMultiImage() async {
    List<XFile> image = await _picker.pickMultiImage(imageQuality: 60);
    selectedImages.addAll(image);

    if (selectedImages.length > 5) {
      showToastError(msg: "Only 5 images are allowed");
      selectedImages.removeLast();
    }
  }

  void showImageDialog(BuildContext context) {
    for (int i = 0; i < selectedImages.length; i++) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.file(File(selectedImages[i].path)),
          );
        },
      );
    }
  }

  Future<void> getPredefinedProblems() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http
          .get(Uri.parse("$apiUrl/pre_defined_problem_read"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var data = ModelProblems.fromJson(json);
        problemsDataList.value = data.data ?? [];
      } else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  final scrollController = ScrollController();
  var isLoading = false.obs;
  var complainsDataList = <Complain>[].obs;
  var photosDataList = [].obs;



  Future<void> getComplains({required var selectedDate}) async {
    try {
      log(selectedDate.toString());
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      var response = await http.get(
          Uri.parse("$apiUrl/complain_tb_read/$branchId?created_on=$selectedDate"),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200){
        var json = jsonDecode(response.body);
        var data = ModelViewComplain.fromJson(json);
        complainsDataList.value = data.complain ?? [];
        log(json.toString());
        jsonList = [json];
      }
      else {
        log('failed ${response.body}');
        jsonList = [];
      }
    } catch (e) {
      log(e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<void> updateData({required int complainId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.post(
          Uri.parse("$apiUrl/complain_tb_update/$complainId"),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "Machine_no":machineNoController.text,
            "Machine_name":machineNameController.text,
            "problems":problem.join(","),
            "problem_description":descriptionController.text,
          })
      );
      if (response.statusCode == 200){
        showToast(msg: "Complain updated Successfully");
        Get.back();
        getComplains(selectedDate: selectedDate.value);
      }
      else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    }
    finally{
      isLoading.value = false;
    }

  }

  Future<void> deleteComplain({required int complainId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.delete(
          Uri.parse("$apiUrl/complain_tb_delete/$complainId"),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200){
        showToast(msg: "Complain deleted Successfully");
        Get.back();
        getComplains(selectedDate: selectedDate.value);
      }
      else {
        showToastError(msg: response.body);
        log(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }


}
