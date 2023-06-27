import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/Model/model_mlgd_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';

class ViewMlgdDataRunWiseController extends GetxController {

  Future<http.Response> getData(runNo) async {
    isLoading.value = true;
    var url = "$apiUrl/view_mlgd_data?runNo=$runNo";
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var data = ModelMlgdData.fromJson(json);
      mlgdDataList.value = data.data ?? [];
      isLoading.value = false;
      return response;
    }
    else{
      isLoading.value = false;
      mlgdDataList.value = [];
      throw Exception();
    }
  }

  var mlgdDataList = <MlgdData>[].obs;
  final runController = TextEditingController();
  var isLoading = false.obs;
  final cleanPcsController = TextEditingController();
  final breakagePcsController = TextEditingController();
  final dotPcsController = TextEditingController();
  final inclusionPcsController = TextEditingController();
  final xController = TextEditingController();
  final yController = TextEditingController();
  final zController = TextEditingController();
  final tController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> updateMlgdData({required int mlgdId}) async {
    try {
      isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var uploadUrl = '$apiUrl/update_mlgd_data/$mlgdId';
      var uri = Uri.parse(uploadUrl);
      var request = http.MultipartRequest("PUT", uri);
      // request.headers.addAll({'Authorization': 'Bearer $token'});
      request.headers['Authorization'] = 'Bearer $token';

      request.fields["cleanPcsNo"] = cleanPcsController.text;
      request.fields["breakagePcs"] = breakagePcsController.text;
      request.fields["dotPcs"] = dotPcsController.text;
      request.fields["inclusionPcs"] = inclusionPcsController.text;
      request.fields["x"] = xController.text;
      request.fields["y"] = yController.text;
      request.fields["z"] = zController.text;
      request.fields["t"] = tController.text;

      var response = await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        showToast(msg: "Data Updated Successfully");
        clearData();
        Get.back();
        getData(runController.text);
        isLoading.value = false;
      } else {

        isLoading.value = false;
        Get.showSnackbar(GetSnackBar(
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          title: "Error : ${response.statusCode}",
          message: "error",
          duration: const Duration(seconds: 2),
        ));
      }
    }
    catch(e){
      log(e.toString());
    }
  }

  void clearData() {
    cleanPcsController.clear();
    breakagePcsController.clear();
    dotPcsController.clear();
    inclusionPcsController.clear();
    xController.clear();
    yController.clear();
    zController.clear();
    tController.clear();
  }

  Future<void> deleteMlgdData({required int mlgdId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.delete(Uri.parse("$apiUrl/delete_mlgd_data/$mlgdId"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        showToast(msg: "Mlgd Data Deleted Successfully");
        Get.back();
        getData(runController.text);
        clearData();
      } else {
        showToastError(msg: "Can't Delete Mlgd Data");
        isLoading.value = false;
      }
    } catch (e) {
      showToastError(msg: "Can't Delete Mlgd Data");
      isLoading.value = false;
      log("Error: $e");
    }
    finally{
      isLoading.value = false;
    }
  }
}