import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/ups_reading/controllers/ups_reading_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';
import '../Model/model_ups_data.dart';

class UpsDataController extends GetxController {
  var isLoading = false.obs;
  var upsDataList = <UpsData>[].obs;

  final addUpsNameController = TextEditingController();
  final updateUpsNameController = TextEditingController();
  final instance = Get.put(UpsReadingController());
  UpsReadingController upsReadingController = Get.find();

  @override
  void onInit() {
    fetchUps();
    super.onInit();
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
  Future<void> addUpsData() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_ups_data'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': "application/json"
        },
        body: jsonEncode(<String, dynamic>{"ups_name": addUpsNameController.text}));
    if (response.statusCode == 200) {
      Get.back();
      isLoading.value = false;
      showToast(msg: "Ups Added Successfully");
      fetchUps();
      addUpsNameController.clear();
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't add ups ${response.statusCode}");
      throw Exception('Failed to load branches');
    }
  }

  Future<void> updateUpsData({required int id}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.put(Uri.parse('$apiUrl/update_ups_data/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': "application/json"
        },
        body: jsonEncode(<String, dynamic>{"ups_name": updateUpsNameController.text}));
    if (response.statusCode == 200) {
      Get.back();
      isLoading.value = false;
      showToast(msg: "Ups Updated Successfully");
      fetchUps();
      updateUpsNameController.clear();
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't update ups ${response.statusCode}");
      throw Exception('Failed to load branches');
    }
  }

  Future<void> deleteUpsData({required int id}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$apiUrl/delete_ups_data/$id'),
        headers: {
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      Get.back();
      isLoading.value = false;
      showToast(msg: "Ups Deleted Successfully");
      fetchUps();
      updateUpsNameController.clear();
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't delete ups ${response.statusCode}");
      throw Exception('Failed to delete ups data');
    }
  }
}
