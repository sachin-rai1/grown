import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/notification_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = "http://ec2-34-197-250-249.compute-1.amazonaws.com/api";
// String apiUrl = kIsWeb?'http://127.0.0.1:5000/api': 'http://10.0.2.2:5000/api';
// String apiUrl = "http://192.168.6.201:5000/api";
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
      var response = await http.post(Uri.parse("$apiUrl/send_email"),
          body: jsonEncode(<String, dynamic>{
            "sender_email": email,
            "password": password,
            "recipients_email":
                receipents ?? mailReceiver ?? ["ganeshrai159@gmail.com"],
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
    } catch (e) {
      log(e.toString());
    }
  }
}

showToast({msg}) {
  if (!Platform.isWindows) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  } else {
    Get.showSnackbar(GetSnackBar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      title: "Success",
      message: msg,
      duration: const Duration(milliseconds: 2000),
    ));
  }
}

showToastError({msg}) {
  if(!Platform.isWindows) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
  else {
    Get.showSnackbar(GetSnackBar(
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      title: "Error",
      message: msg,
      duration: const Duration(milliseconds: 2000),
    ));
  }
}

class Api {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    NotificationSettings settings = await messaging.requestPermission(
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
        log("Push Token : $t");
      }
    }).catchError((error) {
      log('Firebase token retrieval error: $error');
    });
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        NotificationService().showNotification(
            message.notification!.title!, message.notification!.body!);
      });
    }
  }

  static Future<void> sendPushNotification(
      {required String msg,
      required List<String> token,
      required String title}) async {
    try {
      final msgBody = {
        "registration_ids": token,
        "notification": {
          "title": title,
          "body": msg,
          "android_channel_id": "chats",
        }
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
      var response = await post(url, body: jsonEncode(msgBody), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            "key = AAAA17z7YKM:APA91bE4vVotRJTbOeCc7nc25xFL9-uGQ5I1pSO_p2KZljC6ImQ3JxnLVMb3xWcxq9nq9o-Emt9wMaZnRLqNbUVYDmtZLMm1yTxzmrZE_Ajj_R2Yw5mxzpGSpDu7DS2D0hQujc-sNY_U"
      });
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (e) {
      log("Error : $e");
    }
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });

  String? title;
  String? body;
}



Future<void> convertToExcel({required List<Map<String, dynamic>> jsonList, required String fileName, String? jsonKey}) async {

  bool success = await writeToFile(jsonList, fileName,jsonKey??"data");
  if (success) {
    log("Excel file created successfully.");
    showToast(msg: "File Saved In Downloads OR Documents Folder");

  } else {
    log("Failed to create Excel file.");
    showToastError(msg: "No Data Found");
  }
}
Future<bool> writeToFile(List<Map<String, dynamic>> data, String fileName , String jsonKey) async {
  try {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    //write the header
    sheet.appendRow(data[0][jsonKey][0].keys.toList());

    // Write the data
    for(int i = 0 ; i<data[0][jsonKey].length ; i++){
      sheet.appendRow(data[0][jsonKey][i].values.toList());
    }

    if(!kIsWeb) {
      Directory? directory;

      if (Platform.isIOS || Platform.isWindows) {
        directory = await getApplicationDocumentsDirectory();
      }
      else {
        directory = Directory('/storage/emulated/0/Download');
      }

      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }

      String filePath = '${directory!.path}/$fileName${DateTime.now().microsecondsSinceEpoch}.xlsx';
      var file = File(filePath);
      await file.writeAsBytes(excel.encode()!);
    }
    return true;
  } catch (e) {
    log("Error creating Excel file: $e");
    return false;
  }
}