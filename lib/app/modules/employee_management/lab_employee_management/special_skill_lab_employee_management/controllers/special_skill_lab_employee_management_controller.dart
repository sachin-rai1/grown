import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/employee_management/lab_employee_management/controllers/lab_employee_management_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../../../data/constants.dart';
import '../../designation_lab_employee_management/model_emp_by_designation.dart';

class SpecialSkillLabEmployeeManagementController extends GetxController {
  dynamic argumentData = Get.arguments;
  var employees = <Employee>[].obs;
  var selectedBranch = "".obs;
  var branchId = 0.obs;
  var branchData = [].obs;
  var designationData = [].obs;
  var specialSkillData = [].obs;
  final nameController = TextEditingController();
  final updateNameController = TextEditingController();
  var designationId = 0.obs;
  var specialSkillId = 0.obs;
  var hintText = "".obs;
  final instance = Get.put(LabEmployeeManagementController());
  LabEmployeeManagementController labEmployeeManagementController = Get.find();
  dynamic argumentSkillId;
  dynamic argumentBranchId;
  dynamic argBranchName;
  // dynamic argDesignationName;
  dynamic argSkillName;
  var isLoading = false.obs;

  @override
  void onInit() {
    getEmployeeBySkill(argumentData[0]["skillId"], argumentData[1]["branchId"]).whenComplete(() => getBranches().whenComplete(() => getDesignation().whenComplete(() => getSpecialSkill())));
    argumentSkillId = argumentData[0]["skillId"];
    argumentBranchId = argumentData[1]["branchId"];
    argBranchName = argumentData[2]["branchName"];
    argSkillName = argumentData[3]["skill"];
    super.onInit();
  }

  Future<void> getEmployeeBySkill(int skillId , int branchId) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(
        Uri.parse("$apiUrl/employee_by_skill/$skillId/$branchId") ,
        headers: {
          'Authorization':'Bearer $token'
        }
    );
    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final emp = EmployeesByDesignation.fromJson(data);
      employees.value = emp.employees ?? [];
      isLoading.value = false;
    }
    else{
      employees.value = [];
      isLoading.value = false;
    }
  }

  Future<void> getBranches() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(Uri.parse('$apiUrl/branches'),
        headers: {"Authorization": "Bearer $token"});
    branchData.value = jsonDecode(response.body);
  }

  Future<void> getDesignation() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(Uri.parse('$apiUrl/designation'),
        headers: {"Authorization": "Bearer $token"});
    designationData.value = jsonDecode(response.body);
    // print(designationData);
  }

  Future<void> getSpecialSkill() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await http.get(Uri.parse('$apiUrl/special_skill'),
        headers: {"Authorization": "Bearer $token"});
    specialSkillData.value = jsonDecode(response.body);

  }

  Future<void> updateEmployee(int id) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.put(Uri.parse('$apiUrl/update_employee/$id'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(<String, dynamic>{
          "emp_name": (updateNameController.text == "")
              ? hintText.value
              : updateNameController.text,
          "emp_designation":designationId.value,
          "emp_branch": branchId.value,
          "emp_ss": specialSkillId.value
        }));

    if (response.statusCode == 200) {
      Get.back();
      getEmployeeBySkill(argumentSkillId, argumentBranchId).whenComplete(() => labEmployeeManagementController.fetchEmployeesByBranchDetails(argumentBranchId));
      Fluttertoast.showToast(
          msg: "Employee Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      isLoading.value = false;
    }
    else{
      Get.back();
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "Can't Update Employee,Try again Later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> addEmployee() async {
    if(designationId.value == 0){
      Get.showSnackbar(const GetSnackBar(
        message: "No designation Selected",
        title: "Please select Designation",
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      ));
    }
    else if(nameController.text == ""){
      Get.showSnackbar(const GetSnackBar(
        message: "Employee name blank",
        title: "Please Enter Employee Name",
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      ));
      designationId.value = 0;
    }
    else {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.post(Uri.parse("$apiUrl/employee"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, dynamic>{
            "emp_name": nameController.text,
            "emp_designation": designationId.value,
            "emp_branch":(branchId.value == 0)?argumentBranchId: branchId.value,
            "emp_ss": (specialSkillId.value == 0)?argumentSkillId: specialSkillId.value
          }));
      if (response.statusCode == 200) {
        getEmployeeBySkill(argumentSkillId, argumentBranchId).whenComplete(() =>
            labEmployeeManagementController.fetchEmployeesByBranchDetails(argumentBranchId));
        Get.back();
        Fluttertoast.showToast(
            msg: "Employee Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
        nameController.clear();
        isLoading.value = false;
      }
      else{
        Get.back();
        Fluttertoast.showToast(
            msg: "Can't Add Employee,Try Again Later",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteEmployee(int id) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.delete(Uri.parse("$apiUrl/delete_employee/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    if(response.statusCode == 200){
      getEmployeeBySkill(argumentSkillId, argumentBranchId).whenComplete(() => labEmployeeManagementController.fetchEmployeesByBranchDetails(argumentBranchId));
      Get.back();
      Fluttertoast.showToast(
          msg: "Employee deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      isLoading.value = false;
    }
    else{
      Get.back();
      Fluttertoast.showToast(
          msg: "Can't delete Employee, Try again Later",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      isLoading.value = false;
    }
  }
}
