import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../modules/login/Model/ModelUser.dart';

String apiUrl = "http://ec2-34-197-250-249.compute-1.amazonaws.com/api";
RxString privilage = "".obs;
RxString departmentName = "".obs;
RxInt departmentId = 0.obs;
RxString branchName = "".obs;
RxInt branchId = 0.obs;
RxInt userId = 0.obs;

class MailSending {
  Future<void> sendEmail(
      {required String email,
      required String password,
      required String server,
      required String port,
      String? mailReceiver,
      String? msg,
      List<String>? receipents}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');
      var response = await http.post(Uri.parse("$apiUrl/send_email"),
          body: jsonEncode(<String, dynamic>{
            "sender_email": email,
            "password": password,
            "recipients_email": receipents ?? mailReceiver ??
                ["ganeshrai159@gmail.com"],
            "msg": msg ?? "Hii, Ganesh It's Sachin",
            "server": server,
            "port": port,
          }),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer $token"
          });

      if (response.statusCode == 200) {
        showToast(msg: "Mail Sent Successfully");
      } else {
        showToastError(msg: "Unable to Send Mail");
      }
    }
    catch(e){
      log(e.toString());
    }
  }

}

showToast({msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green,
    textColor: Colors.white,
  );
}

showToastError({msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}

class Api{


  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future<void> getFirebaseMessagingToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('fToken');
    await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,

    );

    await messaging.getToken().then((t) {
      if (t != null) {
        token = t;
        log("Push Token : $t");
      }
      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   print('Got a message whilst in the foreground!');
      //   print('Message data: ${message.data}');
      //
      //   if (message.notification != null) {
      //     print(
      //         'Message also contained a notification: ${message.notification}');
      //   }
      // });
    });
  }
}
