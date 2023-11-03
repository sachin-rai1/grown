
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/Model/model_process_pump.dart';
import 'package:grown/app/modules/chiller_reading/controllers/chiller_reading_controller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../Model/model_phase.dart';

class ProcessPumpController extends GetxController {

  var isLoading = false.obs;
  var isProcessPumpLoading = false.obs;
  var phaseDataList = <PhaseData>[].obs;
  var processPumpDataList = <ProcessPumpData>[].obs;
  var selectedPhaseId = 0.obs;
  var selectedBranchId = 0.obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  final processPumpNameController =TextEditingController();
  final updateProcessPumpNameController =TextEditingController();

  var selectedBranchName = "".obs;

  @override
  void onInit(){
    super.onInit();
    selectedBranchName.value =chillerReadingController.branchDataList[0]["branch_name"];
    fetchPhases(branchId: chillerReadingController.branchDataList[0]["branch_id"])
        .whenComplete(() => fetchProcessPump(phaseId: phaseDataList[0].phaseId!).whenComplete(() {
          selectedPhaseId.value = phaseDataList[0].phaseId!;
    }));
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

  Future<void> fetchProcessPump({required int phaseId}) async {
    isProcessPumpLoading.value = true;
    processPumpDataList.value = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get(Uri.parse('$apiUrl/view_process_pump?phase_id_fk=$phaseId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelProcessPump.fromJson(json);
      processPumpDataList.value = data.data ?? [];
      isProcessPumpLoading.value = false;
    } else {
      isProcessPumpLoading.value = false;
    }
  }

  Future<void> addProcessPump() async {
    isProcessPumpLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_process_pump'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
        body: jsonEncode(<String,dynamic>{
          "phase_id_fk": selectedPhaseId.value.toString(),
          "process_pump_name":processPumpNameController.text
        })
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      fetchProcessPump(phaseId: selectedPhaseId.value);
      showToast(msg: "process pump Added Successfully");
      processPumpNameController.clear();
      isProcessPumpLoading.value = false;
    } else if(response.statusCode == 400){
      showToastError(msg: json["message"]);
      isProcessPumpLoading.value = false;
    }
  }

  Future<void> updateProcessPump({required int cppId}) async {
    isProcessPumpLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.put(Uri.parse('$apiUrl/update_process_pump/$cppId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },
        body: jsonEncode(<String,dynamic>{
          "process_pump_name":updateProcessPumpNameController.text
        })
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchProcessPump(phaseId: selectedPhaseId.value);
      showToast(msg: "Chiller Updated Successfully");
      updateProcessPumpNameController.clear();
      isProcessPumpLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
    }
  }

  Future<void> deleteProcessPump({required int cppId}) async {
    isProcessPumpLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$apiUrl/delete_process_pump/$cppId'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type':'application/json'
    },);

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchProcessPump(phaseId: selectedPhaseId.value);
      showToast(msg: "Chiller Deleted Successfully");
      isProcessPumpLoading.value = false;
    } else {
      isProcessPumpLoading.value = false;
      showToastError(msg: "Can't Delete ,${response.statusCode}");
    }
  }
}
