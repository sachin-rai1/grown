import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../Model/model_chiller_compressor_reading.dart';
import '../../Model/model_chiller_reading.dart';
import 'package:http/http.dart' as http;

import '../../Model/model_process_pump_reading.dart';
import '../../controllers/chiller_reading_controller.dart';
class BranchwiseChillerReadingController extends GetxController {
  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;
  var isLoading = false.obs;
  final inletTemperatureController = TextEditingController();
  final outletTemperatureController = TextEditingController();
  final averageLoadController = TextEditingController();
  final processPumpPressureController = TextEditingController();

  var chillerReadingDataList = <ChillerReadingData>[].obs;
  var chillerCompressorDataList = <ChillerCompressorData>[].obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  var selectedBranchId = 0.obs;
  var isCompressorLoading = false.obs;

  var processPumpDataList = <ProcessPumpReading>[].obs;
  var isProcessPumpLoading = false.obs;

  List<Map<String, dynamic>> jsonList = [];

  var selectedBranchName = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchChillerReading(branchId: chillerReadingController.branchDataList[0]["branch_id"]);
    selectedBranchId.value = chillerReadingController.branchDataList[0]["branch_id"];
    selectedBranchName.value =  chillerReadingController.branchDataList[0]["branch_name"];
  }


  Future<void> fetchProcessPumpReading({required var chillerReadingId}) async {
    isProcessPumpLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/view_process_pump_reading?cr_id_fk=$chillerReadingId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelProcessPumpReading.fromJson(json);
      processPumpDataList.value = data.data ?? [];

      isProcessPumpLoading.value = false;
    } else {
      isProcessPumpLoading.value = false;
      processPumpDataList.value = [];
      log(response.body.toString());
    }
  }

  Future<void> fetchChillerReading({required var branchId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_reading?branch_id=$branchId'), headers: {
      'Authorization': 'Bearer $token',
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChillerReading.fromJson(json);
      chillerReadingDataList.value = data.data ?? [];
      jsonList = [json];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      chillerReadingDataList.value = [];
      jsonList = [];
      log(response.body.toString());
    }
  }

  Future<void> fetchChillerCompressorReading({required var chillerReadingId}) async {
    isCompressorLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_compressor_reading?cr_id=$chillerReadingId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChillerCompressorReading.fromJson(json);
      chillerCompressorDataList.value = data.data ?? [];
      isCompressorLoading.value = false;
    } else {
      isCompressorLoading.value = false;
      chillerCompressorDataList.value = [];
      log(response.body.toString());
    }
  }
  Future<void> deleteChillerReading({required int readingId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_chiller_reading/$readingId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      },
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchChillerReading(branchId: selectedBranchId.value);
      showToast(msg: "Chiller Reading Deleted Successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't Delete ,${response.body}");
    }
  }

  Future<void> updateChillerReadingData({required int readingId}) async {

    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.put(Uri.parse('$apiUrl/update_chiller_reading/$readingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, String>{
          "inlet_temperature": inletTemperatureController.text,
          "outlet_temperature": outletTemperatureController.text,
          "average_load": averageLoadController.text,
          "process_pump_pressure":processPumpPressureController.text
        }));

    if (response.statusCode == 200) {
      Get.back();
      fetchChillerReading(branchId: selectedBranchId.value);
      showToast(msg: "Chiller Reading Updated Successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't Update ,${response.body}");
      log(response.body);
    }
  }
}
