import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/login/views/login_view.dart';
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
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            "user_email": userName.text,
            "user_password": password.text,
          }));
      log(response.request.toString());
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        var token = data["token"];
        privilage.value = data["privilage"] ?? "";
        departmentName.value = data["user_department_name"];
        departmentId.value = data["user_department_id"];
        branchName.value = data["user_branch_name"];
        branchId.value = data["user_branch_id"];
        userId.value = data["user_id"];
        var userEmail = data["user_email"];

        if (!kIsWeb){
          if(Platform.isAndroid || Platform.isIOS) {
            final fcmToken = await FirebaseMessaging.instance.getToken().catchError((error) {
              log('Firebase token retrieval error: $error');
              return '';
            });
            prefs.setString('fToken', fcmToken!);
          }
      }

        prefs.setString("token", token);
        prefs.setString('privilage', privilage.value);
        prefs.setString('user_department_name', departmentName.value);
        prefs.setInt('user_department_id', departmentId.value);
        prefs.setInt('user_branch_id', branchId.value);
        prefs.setString('user_branch_name', branchName.value);
        prefs.setInt('user_id', userId.value);
        prefs.setString('user_email', userEmail);
        log(userEmail);
        await setFirebaseToken();

        await getEmailConfig();
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

  Future<void> getEmailConfig() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');

      var response = await http.get(
          Uri.parse("$apiUrl/email_setting_read?branch_id=$branchId"),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          }
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        var senderMail = data["data"][0]["sender_email"];
        var server = data["data"][0]["server"];
        var port = data["data"][0]["port"];
        var emailPass = data["data"][0]["pass"];
        var receiverEmail = data["data"][0]["receiver_email"];

        prefs.setString("sender_email", senderMail);
        prefs.setString('server', server);
        prefs.setString('port', port);
        prefs.setString('email_pass', emailPass);
        prefs.setString('receiver_email', receiverEmail);
      }
    }
    catch(e){
      log(e.toString());
    }

  }

  Future<void> setFirebaseToken() async {
    try {

      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');
      var fbToken = prefs.getString('fToken');

      var response = await http.post(
          Uri.parse("$apiUrl/generate_fcm_token"),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          },
        body: jsonEncode(<String,dynamic>{
          "user_id":userId,
          "fcm_token":fbToken
        })
      );

      if (response.statusCode == 200) {
          log("token set successfully");
          Get.offAll(() => HomeView());
      }
      else{
        showToastError(msg: response.body);
        Get.offAll(()=>LoginView());
      }
    }
    catch(e){
      log(e.toString());
    }

  }

}
