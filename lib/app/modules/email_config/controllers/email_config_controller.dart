import 'dart:convert';
import 'package:grown/app/modules/login/controllers/login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailConfigController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final serverController = TextEditingController();
  final portController = TextEditingController();
  final receiverMailController = TextEditingController();
  final loginController = Get.put(LoginController());
  var mailSend = MailSending();

  @override
  void onInit(){
    super.onInit();
    getEmailDetails();
  }


  void sendTestMail() {
    if(receiverMailController.text == ""){
     showToastError(msg: "Please Enter email for testing");
    }
    else {
      mailSend.sendEmail(
          email: emailController.text,
          password: passwordController.text,
          server: serverController.text,
          port: portController.text,
          msg: "Hii This is for testing",
          mailReceiver: receiverMailController.text
      );
    }
  }

  Future<void> getEmailDetails() async {
    var prefs = await SharedPreferences.getInstance();
    emailController.text = prefs.getString("sender_email")??"";
    passwordController.text = prefs.getString('email_pass')??"";
    serverController.text = prefs.getString('server')??"";
    portController.text = prefs.getString('port')??"";
    receiverMailController.text = prefs.getString('receiver_email')??"";
  }


  Future<void> saveEmailDetails() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getInt('user_id');
    var response = await http.post(
        Uri.parse("$apiUrl/email_setting_insert"),
        body: jsonEncode(<String,dynamic>{
          "user_id_fk":userId.toString(),
          "sender_email":emailController.text,
          "password":passwordController.text,
          "recipients_email":[receiverMailController.text],
          "msg":"Hii, This is a testing Mail",
          "server":serverController.text,
          "port":portController.text,
          "receiving_email":receiverMailController.text
        }),
        headers: {
          "Content-type":"application/json",
          "Authorization":"Bearer $token"
        }
    );

    if(response.statusCode == 200){
      showToast(msg: "Settings Saved Successfully");
    }
    else{
      showToastError(msg: "Unable to Save Settings");
    }
  }

}
