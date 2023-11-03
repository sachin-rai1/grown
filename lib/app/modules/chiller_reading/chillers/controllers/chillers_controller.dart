import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../data/constants.dart';
import '../../Model/model_chiller.dart';
import '../../Model/model_phase.dart';
import '../../controllers/chiller_reading_controller.dart';

class ChillersController extends GetxController {

  var isLoading = false.obs;
  var isChillerLoading = false.obs;
  var phaseDataList = <PhaseData>[].obs;
  var chillerDataList = <ChillerData>[].obs;
  var selectedPhaseId = 0.obs;
  var selectedBranchId = 0.obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  final chillerNameController =TextEditingController();
  final updateChillerNameController =TextEditingController();

  var selectedBranchName = "".obs;

  @override
  void onInit(){
    super.onInit();
    selectedBranchName.value =chillerReadingController.branchDataList[0]["branch_name"];
    fetchPhases(branchId: chillerReadingController.branchDataList[0]["branch_id"]).whenComplete(() => fetchChiller(phaseId: phaseDataList[0].phaseId!).whenComplete(() => selectedPhaseId.value = phaseDataList[0].phaseId!));
  }

  Future<void> fetchPhases({required int branchId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_phase/$branchId'), headers: {
      'Authorization': 'Bearer $token',
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = Modelphase.fromJson(json);
      phaseDataList.value = data.data ?? [];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      phaseDataList.value = [];
    }
  }

  Future<void> fetchChiller({required int phaseId}) async {
    isChillerLoading.value = true;
    chillerDataList.value = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get(Uri.parse('$apiUrl/get_chiller/$phaseId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChiller.fromJson(json);
      chillerDataList.value = data.data ?? [];
      isChillerLoading.value = false;
    } else {
      isChillerLoading.value = false;
    }
  }

  Future<void> addChiller() async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_chiller'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
        body: jsonEncode(<String,dynamic>{
          "phase_id": selectedPhaseId.value.toString(),
          "chiller_name":chillerNameController.text
        })
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      fetchChiller(phaseId: selectedPhaseId.value);
      showToast(msg: "Chiller Added Successfully");
      chillerNameController.clear();
      isChillerLoading.value = false;
    } else if(response.statusCode == 400){
      showToastError(msg: json["message"]);
      isChillerLoading.value = false;
    }
  }

  Future<void> updateChiller({required int chillerId}) async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.put(Uri.parse('$apiUrl/update_chiller/$chillerId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
        body: jsonEncode(<String,dynamic>{
          "chiller_name":updateChillerNameController.text
        })
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchChiller(phaseId: selectedPhaseId.value);
      showToast(msg: "Chiller Updated Successfully");
      updateChillerNameController.clear();
      isChillerLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
    }
  }

  Future<void> deleteChiller({required int chillerId}) async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$apiUrl/delete_chiller/$chillerId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchChiller(phaseId: selectedPhaseId.value);
      showToast(msg: "Chiller Deleted Successfully");
      isChillerLoading.value = false;
    } else {
      isChillerLoading.value = false;
      showToastError(msg: "Can't Delete ,Other Data Already Exists");
    }
  }
}
