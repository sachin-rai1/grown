import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

  String apiUrl = "http://ec2-34-197-250-249.compute-1.amazonaws.com/api";
  RxString privilage = "".obs;
  RxString departmentName = "".obs;
  RxInt departmentId = 0.obs;
  RxString branchName = "".obs;
  RxInt branchId = 0.obs;

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

