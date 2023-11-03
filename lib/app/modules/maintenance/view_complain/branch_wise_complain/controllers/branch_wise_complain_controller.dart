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

class BranchWiseComplainController extends GetxController {

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

  var selectedBranchName = ''.obs;

  var selectedBranchId = 0.obs;
  var branchDataList = [].obs;




  @override
  Future<void> onInit() async {
    super.onInit();
    await getComplains(branchId: selectedBranchId.value);
    fetchBranches();
    await getPredefinedProblems();
    scrollController.addListener(scrollListner);
  }

  Future<void> fetchBranches() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {

        branchDataList.value = jsonDecode(response.body);
        selectedBranchId.value = branchDataList[0]["branch_id"];
        selectedBranchName.value = branchDataList[0]["branch_name"];
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
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



  Future<void> getComplains({required int branchId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/complain_tb_read/$branchId"),
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
        complainsDataList.value = [];
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
        getComplains(branchId: selectedBranchId.value);
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
        getComplains(branchId: selectedBranchId.value);
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

  void scrollListner() {
    if(scrollController.position.pixels ==  scrollController.position.maxScrollExtent){
      log("Hey");
    }
  }
}
