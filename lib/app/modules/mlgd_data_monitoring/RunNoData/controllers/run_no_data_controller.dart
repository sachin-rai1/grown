import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/Model/model_run_no.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';

class RunNoDataController extends GetxController {

  var isLoading = false.obs;
  var runNoDataList = <RunNoData>[].obs;
  final formKey = GlobalKey<FormState>();

  final runNoController = TextEditingController();
  final runningHoursController = TextEditingController();
  var size = ''.obs;
  final totalPcsNoController = TextEditingController();
  final totalPcsAreaController = TextEditingController();
  final bigPcsNoController = TextEditingController();
  final regularPcsNumberController = TextEditingController();

  final updateRunNoController = TextEditingController();
  final updateRunningHoursController = TextEditingController();
  var updateSize = ''.obs;
  final updateTotalPcsNoController = TextEditingController();
  final updateTotalPcsAreaController = TextEditingController();
  final updateBigPcsNoController = TextEditingController();
  final updateRegularPcsNumberController = TextEditingController();

  @override
  void onInit(){
    super.onInit();
    fetchRunNoData();
  }

  void clearData(){
    runNoController.clear();
    runningHoursController.clear();
    size.value = "";
    totalPcsNoController.clear();
    totalPcsAreaController.clear();
    bigPcsNoController.clear();
    regularPcsNumberController.clear();

    updateRunNoController.clear();
    updateRunningHoursController.clear();
    updateSize.value = "";
    updateTotalPcsNoController.clear();
    updateTotalPcsAreaController.clear();
    updateBigPcsNoController.clear();
    updateRegularPcsNumberController.clear();
  }

  Future<void> fetchRunNoData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("$apiUrl/view_run_no"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelRunNoData.fromJson(json);
        runNoDataList.value = data.data ?? [];
        isLoading.value = false;
        clearData();
      } else {
        isLoading.value = false;
        log("Error: ${response.statusCode}");
      }
    } catch (e) {
      isLoading.value = false;
      log("Error: $e");
    }
    finally{

    }
  }

  Future<void> addRunNoData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.post(Uri.parse("$apiUrl/add_run_no"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String , dynamic>{
          "runNo":runNoController.text,
          "holderSize":size.value,
          "totalPcsNo":totalPcsNoController.text,
          "totalPcsArea":totalPcsAreaController.text,
          "bigPcsNo":bigPcsNoController.text,
          "regularPcsNo":regularPcsNumberController.text,
        })
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        showToast(msg: "Run No Added Successfully");
        Get.back();
        fetchRunNoData();
      } else {
        showToastError(msg: "Can't Add Run No");
        isLoading.value = false;
      }
    } catch (e) {
      showToastError(msg: "Can't Add Run No");
      isLoading.value = false;
      log("Error: $e");
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<void> updateRunNo({required int runId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.put(Uri.parse("$apiUrl/update_run_no/$runId"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String , dynamic>{
            "runningHours":updateRunningHoursController.text,
            "holderSize":updateSize.value,
            "totalPcsNo":updateTotalPcsNoController.text,
            "totalPcsArea":updateTotalPcsAreaController.text,
            "bigPcsNo":updateBigPcsNoController.text,
            "regularPcsNo":updateRegularPcsNumberController.text,
          })
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        showToast(msg: "Run No Updated Successfully");
        Get.back();
        fetchRunNoData();
        clearData();
      } else {
        showToastError(msg: "Can't Update Run No");
        isLoading.value = false;
      }
    } catch (e) {
      showToastError(msg: "Can't Update Run No");
      isLoading.value = false;
      log("Error: $e");
    }
    finally{
      isLoading.value = false;
    }

  }

  Future<void> deleteRunNo({required int runId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.delete(Uri.parse("$apiUrl/delete_run_no/$runId"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        showToast(msg: "Run No Deleted Successfully");
        Get.back();
        fetchRunNoData();
        clearData();
      } else {
        showToastError(msg: "Can't Delete Run No");
        isLoading.value = false;
      }
    } catch (e) {
      showToastError(msg: "Can't Delete Run No");
      isLoading.value = false;
      log("Error: $e");
    }
    finally{
      isLoading.value = false;
    }

  }
}
