import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/RunNoData/controllers/run_no_data_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';
import '../../Model/model_run_no.dart';

class PostRunController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final runNoController = TextEditingController();
  final finalHeightController = TextEditingController();
  final finalWeightController = TextEditingController();
  final remarksController = TextEditingController();
  var isLoading = false.obs;
  var runNoDataList = [].obs;

  var runNoStatus= 0.obs;

  var readOnly = true.obs;

  var selectedObjective = 'P-P'.obs;
  var isRunNoLoading = false.obs;

  RunNoDataController runNoDataController = Get.find();



  final List<String> objectiveDropDownItems = [
    'P-P',
    'P-B',
    'P-M',
    'B-B',
    'B-M',
  ];

  var selectedShutDownReason = 'Processing Finished'.obs;

  final List<String> shutDownDropDownItems = [
    'Processing Finished',
    'Temperature High',
    'Temperature Low',
    'MW',
    'Gas',
    'Electric'
  ];

  Future<void> searchRunNoData({required int runNo}) async {
    try {
      isRunNoLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.get(
          Uri.parse("$apiUrl/view_run_no?run_id=$runNo"),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        runNoStatus.value = 200;
        var json = jsonDecode(response.body);
        var data = ModelRunNoData.fromJson(json);
        runNoDataList.value = data.data ?? [];
        isRunNoLoading.value = false;
      }
      else{
        runNoStatus.value = response.statusCode;
      }
    } catch (e) {
      isRunNoLoading.value = false;
    } finally {
      isRunNoLoading.value = false;
    }
  }

  Future<void> addPostRunData() async{
    try{
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');

      var response = await http.post(
          Uri.parse("$apiUrl/add_post_run_data"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type':'application/json'
          },
        body: jsonEncode(<String,dynamic>{
          "runNo":runNoController.text,
          "finalHeight":finalHeightController.text,
          "finalWeight":finalWeightController.text,
          "objective":selectedObjective.value,
          "shutDownReason":selectedShutDownReason.value,
          "userId":userId.toString(),
          "remarks":remarksController.text
        })
      );
      if(response.statusCode == 200){
        showToast(msg: "Data Added Successfully");
        clearData();
      }
      else{
        showToastError(msg: response.body);
      }
    }
    catch(e){
      showToastError(msg: e);
      log(e.toString());
    }

  }

  void clearData() {
    runNoController.clear();
    finalWeightController.clear();
    finalHeightController.clear();
    remarksController.clear();
    runNoDataController.fetchRunNoData();
    runNoStatus.value=0;
  }
}
