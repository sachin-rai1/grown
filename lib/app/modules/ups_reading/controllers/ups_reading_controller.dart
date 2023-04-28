import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/ups_reading/upsData/Model/model_ups_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants.dart';

class UpsReadingController extends GetxController {
  final loadOnUpsRController = TextEditingController();
  final loadOnUpsYController = TextEditingController();
  final loadOnUpsBController = TextEditingController();
  final positiveVoltageController = TextEditingController();
  final negativeVoltageController = TextEditingController();
  var ledStatus = "".obs;
  var isLoading = false.obs;

  var branchDataList = [].obs;
  var selectedBranchId = 0.obs;
  var selectedBranch = "".obs;

  final formKey = GlobalKey<FormState>();

  var upsDataList = <UpsData>[].obs;
  var selectedUpsId = 0.obs;

  @override
  void onInit() {
    fetchBranches().whenComplete(() => fetchUps());
    super.onInit();
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
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  Future<void> fetchUps() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
        await http.get(Uri.parse('$apiUrl/view_ups_data'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var upsData = ModelUpsData.fromJson(json);
      upsDataList.value = upsData.data!;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  Future<void> addUpsReading() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_ups_reading'), headers: {
      'Authorization': 'Bearer $token',
      'Content-type': 'application/json'
    },
      body: jsonEncode(<String, dynamic>{
        "branch_id":selectedBranchId.value,
        "ups_id":selectedUpsId.value,
        "loads_on_ups_r": loadOnUpsRController.text,
        "loads_on_ups_y":loadOnUpsYController.text,
        "loads_on_ups_b":loadOnUpsBController.text,
        "led_status":ledStatus.value,
        "dc_positive_voltage":positiveVoltageController.text,
        "dc_negative_voltage":negativeVoltageController.text
      })
    );

    if (response.statusCode == 200) {

      showToast(msg: "Ups Reading Added Successfully");
      isLoading.value = false;
      clearData();
    } else {
      isLoading.value = false;
      showToast(msg: response.body + response.statusCode.toString());
      throw Exception(response.body + response.statusCode.toString());
    }
  }

  void clearData() {
    selectedUpsId.value = 0;
    selectedBranchId.value = 0;
    loadOnUpsRController.clear();
    loadOnUpsYController.clear();
    loadOnUpsBController.clear();
    ledStatus.value = "0";
    positiveVoltageController.clear();
    negativeVoltageController.clear();
  }
}
