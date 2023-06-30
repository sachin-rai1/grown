import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/pre_run_view_data/Model/model_pre_run_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class PreRunViewDataController extends GetxController {
  final runNoController = TextEditingController();
  var preRunDataList = <PreRunData>[].obs;
  var isLoading = false.obs;
  var isNoDataFound = false.obs;
  var selectedImageType = 1.obs;

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


  @override
  void onInit(){
    super.onInit();
    getAllPreRunData();
  }
  Future<void> getAllPreRunData() async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/view_pre_run_data"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPreRunData.fromJson(json);
        preRunDataList.value = data.data ?? [];
      }
    } finally {
      isLoading.value = false;
    }
  }


  Future<http.Response> getPreRunDataRunNoWise({required int runNo}) async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/view_pre_run_data?runNo=$runNo"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPreRunData.fromJson(json);
        preRunDataList.value = data.data ?? [];
        return response;
      }
      else{
        throw Exception();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
