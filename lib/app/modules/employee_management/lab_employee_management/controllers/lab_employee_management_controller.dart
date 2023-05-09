import 'dart:convert';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../emp_model.dart';

class LabEmployeeManagementController extends GetxController {
  var selectedBranch = "".obs;
  var branchId = 1.obs;
  var designationDetails = <DesignationCount>[].obs;

  var specialSkill = <DesignationCount>[].obs;
  var totalMachines = 0.obs;
  var totalEmployees = 0.obs;
  var requireEmployees = 0.obs;

  var requiredDesignations = <DesignationCount>[].obs;
  var requiredSkill = <DesignationCount>[].obs;
  var branchData = [].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchBranches().whenComplete(() => fetchEmployeesByBranchDetails(branchId.value));
  }
  Future<List> fetchBranches() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        branchData.value = jsonDecode(response.body);
      }
      isLoading.value = false;
      return branchData;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }


  Future<void> fetchEmployeesByBranchDetails(int id) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response =
    await http.get(Uri.parse('$apiUrl/employees_branch/$id'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final employees = Employees.fromJson(data);
      designationDetails.value = employees.designationCounts ?? [];
      specialSkill.value = employees.skillCounts ?? [];
      totalMachines.value = employees.totalNoOfMachine!.noOfMachines!;
      totalEmployees.value = employees.totalEmployee!;
      requireEmployees.value = employees.requireEmployees!;
      requiredDesignations.value  = employees.requiredDesignationPerHundredMachine ?? [];
      requiredSkill.value = employees.requiredSkillsPerHundredMachine ?? [];
      isLoading.value = false;
    }
  }
}
