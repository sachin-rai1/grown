import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/ups_reading/controllers/ups_reading_controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';
import '../Model/model_ups_reading.dart';

class ViewUpsReadingDateWiseController extends GetxController {
  var isLoading = false.obs;
  var upsReadingDataList = <UpsReadingData>[].obs;
  var instance = Get.put(UpsReadingController());
  UpsReadingController upsReadingController = Get.find();

  final loadOnUpsRController = TextEditingController();
  final ledStatus = "".obs;
  final positiveVoltageController = TextEditingController();
  final negativeVoltageController = TextEditingController();
  final loadOnUpsYController = TextEditingController();
  final loadOnUpsBController = TextEditingController();
  var selectedBranchId = 0.obs;
  var selectedUpsId = 0.obs;

  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;


  @override
  void onInit() {
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    fetchUpsReadingDataDateWise(formatted);
    super.onInit();
  }

  void clearData(){

  }

  Future<void> fetchUpsReadingDataDateWise(createdOn) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
    await http.get(Uri.parse('$apiUrl/view_ups_reading?created_on=$createdOn'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var upsData = ModelUpsReading.fromJson(json);
      upsReadingDataList.value = upsData.data!;
      isLoading.value = false;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  updateUpsReading({
    required int id ,
    required int branchId,
    required int upsId,
    required int lur,
    required int luy,
    required int lub,
    required RxString led,
    required int positive,
    required int negative}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    final response = await http.put(Uri.parse('$apiUrl/update_ups_reading/$id'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type':'application/json'
    } ,
        body: jsonEncode(<String, dynamic>{
          "branch_id":(selectedBranchId.value == 0)?branchId: selectedBranchId.value,
          "ups_id":(selectedUpsId.value == 0)?upsId: selectedUpsId.value,
          "loads_on_ups_r":( loadOnUpsRController.text == "")?lur:  loadOnUpsRController.text,
          "loads_on_ups_y":(loadOnUpsYController.text == "")?luy: loadOnUpsYController.text,
          "loads_on_ups_b":(loadOnUpsBController.text == "")?lub: loadOnUpsBController.text,
          "led_status":(ledStatus.value == "")?led.value: ledStatus.value,
          "dc_positive_voltage":(positiveVoltageController.text == "")?positive: positiveVoltageController.text,
          "dc_negative_voltage":(negativeVoltageController.text == "")?negative: negativeVoltageController.text
        })
    );

    if (response.statusCode == 200) {
      showToast(msg: "Updated Successfully");
      Get.back();
      fetchUpsReadingDataDateWise(formatted);

      isLoading.value = false;
    } else {
      isLoading.value = false;
      showToastError(msg: "Can't Update : ${response.statusCode}");
      throw Exception('Failed to load branches');
    }
  }

  deleteUpsReadingData({required int id}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(Uri.parse('$apiUrl/delete_ups_reading/$id'), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      showToast(msg: "Updated Successfully");
      Get.back();
      fetchUpsReadingDataDateWise(formatted);
      isLoading.value = false;
    } else {
      showToastError(msg: "Can't Delete :  ${response.statusCode}");
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

}
