import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';

class ViewMlgdDataRunWiseController extends GetxController {
  var data = [].obs;
  final runController = TextEditingController();


  Future<void> getData(runNo) async {

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
      data.value = jsonDecode(response.body);    }
    else{


      data.value = [];
    }
  }
}
