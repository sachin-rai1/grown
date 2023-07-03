import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/constants.dart';
import '../emp_model.dart';

class LabEmployeeManagementController extends GetxController {
  var selectedBranch = "".obs; // Observable variable for the selected branch name
  var branchId = 1.obs; // Observable variable for the branch ID
  var designationDetails = <DesignationCount>[].obs; // Observable list of DesignationCount objects representing designation details

  var specialSkill = <DesignationCount>[].obs; // Observable list of DesignationCount objects representing special skills
  var totalMachines = 0.obs; // Observable variable for the total number of machines
  var totalEmployees = 0.obs; // Observable variable for the total number of employees
  var requireEmployees = 0.obs; // Observable variable for the required number of employees

  var requiredDesignations = <DesignationCount>[].obs; // Observable list of DesignationCount objects representing required designations
  var requiredSkill = <DesignationCount>[].obs; // Observable list of DesignationCount objects representing required skills
  var branchData = [].obs; // Observable list for branch data
  var isLoading = false.obs; // Observable variable indicating if data is being loaded

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
      selectedBranch.value = branchData[0]["branch_name"]; // Set the selected branch to the first branch in the list
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
    var response = await http.get(Uri.parse('$apiUrl/employees_branch/$id'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      final employees = Employees.fromJson(data);
      designationDetails.value = employees.designationCounts ?? []; // Update the designation details with the fetched data
      specialSkill.value = employees.skillCounts ?? []; // Update the special skills with the fetched data
      totalMachines.value = employees.totalNoOfMachine!.noOfMachines!; // Update the total number of machines
      totalEmployees.value = employees.totalEmployee!; // Update the total number of employees
      requireEmployees.value = employees.requireEmployees!; // Update the required number of employees
      requiredDesignations.value = employees.requiredDesignationPerHundredMachine ?? []; // Update the required designations with the fetched data
      requiredSkill.value = employees.requiredSkillsPerHundredMachine ?? []; // Update the required skills with the fetched data
      isLoading.value = false;
    }
  }
}
