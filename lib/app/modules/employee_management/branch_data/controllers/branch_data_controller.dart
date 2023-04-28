import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../data/constants.dart';
import '../../lab_employee_management/controllers/lab_employee_management_controller.dart';
import '../model_branch.dart';

class BranchDataController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getBranches();
  }

  final instance = Get.put(LabEmployeeManagementController());
  LabEmployeeManagementController labEmployeeManagementController = Get.find();

  final updateBranchNameController = TextEditingController();
  final updateNoOfMachinesController = TextEditingController();
  final updateFloorController = TextEditingController();

  final branchNameController = TextEditingController();
  final noOfMachinesController = TextEditingController();
  final floorController = TextEditingController();

  var branchData = [].obs;

  void clearAll(){
    updateBranchNameController.clear();
    updateNoOfMachinesController.clear();
    updateFloorController.clear();
    branchNameController.clear();
    noOfMachinesController.clear();
    floorController.clear();
  }

  Future<void> getBranches() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(Uri.parse('$apiUrl/branches'),
        headers: {"Authorization": "Bearer $token"});

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final branch = data.map((modelBranch) => ModelBranch.fromJson(modelBranch)).toList();
      branchData.value = branch ?? [];
      isLoading.value = false;
    }
    else{
      branchData.value = [];
    }
  }

  Future<void> addBranch() async {
    if (branchNameController.text == "") {
      Get.showSnackbar(const GetSnackBar(
        message: "Branch Name Empty",
        title: "Please Enter Branch Name",
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      ));
    } else {
      isLoading.value = true;

      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.post(Uri.parse("$apiUrl/branches"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, dynamic>{
            "branch_name": branchNameController.text,
            "no_of_machines": noOfMachinesController.text,
            "floor": floorController.text,
          }));
      if (response.statusCode == 200) {
        Get.back();
        getBranches();
        Fluttertoast.showToast(
            msg: "Branch Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        getBranches().whenComplete(() => labEmployeeManagementController.fetchBranches().whenComplete(() => isLoading.value = false));
        clearAll();

      }

    }
  }

  Future<void> updateBranch(
      int id, String branchName, String noOfMachines, String floor) async {

    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.put(Uri.parse("$apiUrl/update/branches/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, dynamic>{
          "branch_name": branchName,
          "no_of_machines": noOfMachines,
          "floor": floor,
        }));
    if (response.statusCode == 200) {
      Get.back();
      Fluttertoast.showToast(
          msg: "Branch Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      getBranches().whenComplete(() => labEmployeeManagementController.fetchBranches().whenComplete(() => isLoading.value = false));
      clearAll();

    }
  }

  Future<void> deleteBranch(int id) async {
    if (labEmployeeManagementController.branchId.value == id) {
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
        Uri.parse("$apiUrl/delete/branches/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        Get.back();
        labEmployeeManagementController.fetchBranches();
        Fluttertoast.showToast(
            msg: "Branch deleted Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        getBranches().whenComplete(() => labEmployeeManagementController.fetchBranches().whenComplete(() => isLoading.value = false));
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
