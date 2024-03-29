import 'dart:convert';
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/pre_run_view_data/Model/model_pre_run_data.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/pre_run/pre_run_view_data/controllers/pre_run_view_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/constants.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../../../Model/model_mlgd_data.dart';
import '../../../running_data/view_running_data_run_wise/controllers/view_mlgd_data_run_wise_controller.dart';
import '../../run_no_wise_post_run_data/Model/model_post_run_data.dart';


class DateWisePostRunDataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(DateTime.parse(DateTime.now().toString()));
    getPostRunDataDateWise(startDate: formatted);
  }

  var isLoading = false.obs;
  var isPreRunDataLoading = false.obs;
  var isRunningDataLoading = false.obs;
  var postRunDataList = <ModelPostRunData>[].obs;
  var preRunDataList = <PreRunData>[].obs;
  var mlgdDataList = <MlgdData>[].obs;
  final runNoController = TextEditingController();
  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;

  final preRunViewData = Get.put(PreRunViewDataController());
  final viewMlgdDataRunWise = Get.put(ViewMlgdDataRunWiseController());

  Future<void> getPreRunData({required int runNO}) async {
    try {
      isPreRunDataLoading.value = true;
      var response = await preRunViewData.getPreRunDataRunNoWise(runNo: runNO);
      if(response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPreRunData.fromJson(json);
        preRunDataList.value = data.data ?? [];
      }
      else{

        preRunDataList.value = [];
      }
    } catch (e) {
      throw Exception();
    }
    finally{
      isPreRunDataLoading.value = false;
    }
  }

  Future<void> getRunningData({required int runNO}) async {
    try {
      isRunningDataLoading.value = true;
      var response = await viewMlgdDataRunWise.getData(runNO);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelMlgdData.fromJson(json);
        mlgdDataList.value = data.data ?? [];
      } else {
        mlgdDataList.value = [];
      }
    } catch (e) {
      throw Exception();
    }
    finally{
      isRunningDataLoading.value = false;
    }
  }



  String changeDateTimeFormat(DateTime dateTime) {
    return DateFormat('dd MMM').format(dateTime);
  }

  Future<http.Response> getPostRunDataRunNoWise({required int runNo}) async {
    log(runNo.toString());
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/view_post_run_data?runNo=$runNo"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPostRunDataReading.fromJson(json);
        postRunDataList.value = data.data ?? [];
        return response;
      }
      else{
        throw Exception();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<http.Response> getPostRunDataDateWise({required String startDate}) async {
    log(startDate);
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/view_post_run_data?startDate=$startDate"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      log(response.body.toString());
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPostRunDataReading.fromJson(json);
        postRunDataList.value = data.data ?? [];
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
