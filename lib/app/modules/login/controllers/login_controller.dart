import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/constants.dart';
import '../../home/views/home_view.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {


  var isLoading = false.obs;
  final userName = TextEditingController();
  final password = TextEditingController();
  var isObscure = true.obs;
  dynamic data = [].obs;

  Future<void> login() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      isLoading.value = true;

      var response = await http.post(Uri.parse("$empManagementApiUrl/login"),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          },
          body: jsonEncode(<String, String>{
            "user_email": userName.text,
            "user_password": password.text,
          }));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print(data);
        var token = data["token"];
        privilage.value = data["privilage"]??"";
        print(privilage);
        prefs.setString("token", token);
        // prefs.setString('privilage', privilage.value);
        Get.offAll(()=>  HomeView() );
        isLoading.value = false;
      } else {
        Get.showSnackbar(const GetSnackBar(
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          title: "Invalid Credential",
          message: "Please Enter Correct UserName or Password",
          duration: Duration(milliseconds: 2000),
        ));
        isLoading.value = false;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
