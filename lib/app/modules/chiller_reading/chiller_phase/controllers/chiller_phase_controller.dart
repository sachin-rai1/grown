import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/controllers/chiller_reading_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../Model/model_phase.dart';

class ChillerPhaseController extends GetxController {

  var isLoading = false.obs;
  var phaseDataList = <PhaseData>[].obs;
  var selectedPhaseId = 0.obs;
  var selectedBranchId = 0.obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  final phaseNameController =TextEditingController();
  final updatePhaseNameController =TextEditingController();

  @override
  void onInit(){
    super.onInit();
    fetchPhases(branchId: chillerReadingController.branchDataList[0]["branch_id"]).whenComplete(() => selectedBranchId.value = chillerReadingController.branchDataList[0]["branch_id"]);

  }

  Future<void> fetchPhases({required int branchId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('$apiUrl/get_chiller_phase/$branchId'), headers: {
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

  Future<void> addPhase() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_chiller_phase'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
    body: jsonEncode(<String,dynamic>{
      "branch_id":selectedBranchId.value.toString(),
      "phase_name":phaseNameController.text
    })
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      phaseNameController.clear();
      fetchPhases(branchId: selectedBranchId.value);
      showToast(msg: "Phase Added Successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
    }
  }

  Future<void> updatePhase({required int phaseId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.put(Uri.parse('$apiUrl/update_chiller_phase/$phaseId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
        body: jsonEncode(<String,dynamic>{
          "phase_name":updatePhaseNameController.text
        })
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      updatePhaseNameController.clear();
      fetchPhases(branchId: selectedBranchId.value);
      showToast(msg: "Phase Updated Successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      phaseDataList.value = [];
    }
  }

  Future<void> deletePhase({required int phaseId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$apiUrl/delete_chiller_phase/$phaseId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchPhases(branchId: selectedBranchId.value);
      showToast(msg: "Phase Deleted Successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't Delete ,Other Data Already Exists");
    }
  }
}