import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../Model/ModelChillerCompressorReading.dart';
import '../../Model/ModelChillerReading.dart';
import 'package:http/http.dart' as http;

import '../../controllers/chiller_reading_controller.dart';
class BranchwiseChillerReadingController extends GetxController {
  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;
  var isLoading = false.obs;
  var chillerReadingDataList = <ChillerReadingData>[].obs;
  var chillerCompressorDataList = <ChillerCompressorData>[].obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  var selectedBranchId = 0.obs;
  var isCompressorLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    fetchChillerReading(branchId: chillerReadingController.branchDataList[0]["branch_id"]);
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
      isLoading.value = false;
    } else {
      isLoading.value = false;
      chillerReadingDataList.value = [];
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
}
