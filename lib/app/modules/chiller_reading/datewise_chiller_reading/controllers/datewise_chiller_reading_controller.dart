import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelChillerCompressorReading.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelChillerReading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';

class DatewiseChillerReadingController extends GetxController {
  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;
  var isLoading = false.obs;
  var chillerReadingDataList = <ChillerReadingData>[].obs;
  var chillerCompressorDataList = <ChillerCompressorData>[].obs;
  var isCompressorLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    fetchChillerReading(selectedDate: formatted);
  }

  Future<void> fetchChillerReading({required var selectedDate}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_reading?created_on=$selectedDate'), headers: {
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
