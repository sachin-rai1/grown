import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GasManifoldController extends GetxController {
  var isLoading = false.obs;
  var manifoldData = [].obs;
  final addManifoldNameController = TextEditingController();
  final updateManifoldNameController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    fetchManifold();
  }

  Future<void> fetchManifold() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$apiUrl/get_gas_manifold"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      manifoldData.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> addManifold() async {
    if (addManifoldNameController.text == "") {
      Fluttertoast.showToast(
          msg: "Enter Gas Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var response = await http.post(Uri.parse("$apiUrl/add_gas_manifold"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
              <String, String>{"manifold_name": addManifoldNameController.text}));
      if (response.statusCode == 200) {
        Get.back();
        Fluttertoast.showToast(
            msg: "Manifold added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        addManifoldNameController.clear();
        isLoading.value = false;
        fetchManifold();

      } else {
        Fluttertoast.showToast(
            msg: "Cannot Add Manifold",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading.value = false;
      }
    }
  }

  Future<void> updateManifold(int id) async {
    if (updateManifoldNameController.text == "") {
      Fluttertoast.showToast(
          msg: "Enter Gas Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var response = await http.put(Uri.parse("$apiUrl/update_gas_manifold/$id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
              <String, String>{"manifold_name": updateManifoldNameController.text}));
      if (response.statusCode == 200) {
        Get.back();
        Fluttertoast.showToast(
            msg: "Manifold Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        updateManifoldNameController.clear();
        isLoading.value = false;
        fetchManifold();
      } else {
        print(response.body);
        Fluttertoast.showToast(
            msg: "Cannot Update Manifold",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteManifold(int id) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.delete(
      Uri.parse("$apiUrl/delete_gas_manifold/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      Get.back();

      Fluttertoast.showToast(
          msg: "Manifold deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      fetchManifold();
    }
    else{
      Get.back();
      Fluttertoast.showToast(
          msg: "Cannot delete , Please try again",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      isLoading.value = false;
    }

  }
}