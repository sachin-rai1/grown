import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Model/model_serial_no_wise.dart';

class SearchBySerialNoController extends GetxController {
  var dataBySerialNo = <SerialWiseData>[].obs;

  final serialNoController = TextEditingController();

  Future<void> fetchDataBySerialNo(var serialNo) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response =await http.get(Uri.parse("$empManagementApiUrl/search_by_serial_no?serial_no=$serialNo") , headers: {
      "Authorization":"Bearer $token",
      "Content-Type":"application/json"
    });

    if(response.statusCode == 200){
      var json = jsonDecode(response.body);
      var data = ModelSerialNoWise.fromJson(json);
      dataBySerialNo.value = data.serialWiseData ?? [];
    }

  }
}
