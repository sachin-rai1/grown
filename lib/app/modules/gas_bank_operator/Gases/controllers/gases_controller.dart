import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/gas_bank_operator/controllers/gas_bank_operator_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GasesController extends GetxController {
  var isLoading = false.obs;
  var gasesData = [].obs;
  final addGasNameController = TextEditingController();
  final updateGasNameController = TextEditingController();
  GasBankOperatorController gasBankOperatorController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchGases();
  }

  Future<void> fetchGases() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$empManagementApiUrl/get_gases"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      gasesData.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> addGases() async {
    if (addGasNameController.text == "") {
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
      var response = await http.post(Uri.parse("$empManagementApiUrl/add_gases"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
              <String, String>{"gases_name": addGasNameController.text}));
      if (response.statusCode == 200) {
        Get.back();
        Fluttertoast.showToast(
            msg: "Gas added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        addGasNameController.clear();
        isLoading.value = false;
        fetchGases().whenComplete(() => gasBankOperatorController.fetchGases());
      } else {
        print(response.body);
        Fluttertoast.showToast(
            msg: "Cannot Add Gas",
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

  Future<void> updateGases(int id) async {
    if (updateGasNameController.text == "") {
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
      var response = await http.put(Uri.parse("$empManagementApiUrl/update_gas_name/$id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(
              <String, String>{"gases_name": updateGasNameController.text}));
      if (response.statusCode == 200) {
        Get.back();
        Fluttertoast.showToast(
            msg: "Gas Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        updateGasNameController.clear();
        isLoading.value = false;
        fetchGases().whenComplete(() => gasBankOperatorController.fetchGases());
      } else {
        print(response.body);
        Fluttertoast.showToast(
            msg: "Cannot Update Gas",
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

  Future<void> deleteGas(int id) async {
    if (gasBankOperatorController.selectedBranchId.value == id) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please select Another Branch and try again",
        title: "Branch already Selected",
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      ));
    } else {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.delete(
        Uri.parse("$empManagementApiUrl/delete_gas_name/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        Get.back();
        gasBankOperatorController.fetchBranches();
        Fluttertoast.showToast(
            msg: "Gas deleted Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        fetchGases().whenComplete(() => gasBankOperatorController.fetchGases().whenComplete(() => isLoading.value = false));
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
}
