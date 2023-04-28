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

      var response = await http.post(Uri.parse("$apiUrl/login"),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            "user_email": userName.text,
            "user_password": password.text,
          }));
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        var token = data["token"];
        privilage.value = data["privilage"]??"";
        departmentName.value = data["user_department_name"];
        departmentId.value = data["user_department_id"];
        branchName.value = data["user_branch_name"];
        branchId.value = data["user_branch_id"];

        prefs.setString("token", token);
        prefs.setString('privilage', privilage.value);
        prefs.setString('user_department_name', departmentName.value);
        prefs.setInt('user_department_id', departmentId.value);
        prefs.setInt('user_branch_id', branchId.value);
        prefs.setString('user_branch_name', branchName.value);


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
