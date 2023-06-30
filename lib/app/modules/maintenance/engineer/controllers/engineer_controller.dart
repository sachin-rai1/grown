import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/maintenance/engineer/model_engineer_problem.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';

class EngineerController extends GetxController {
  var isLoading = false.obs;
  var engineerProblemDataList = <EngineersProblem>[].obs;
  List<String> problem = [];
  var isCheckedList = [].obs;
  final descriptionController = TextEditingController();
  var status = 0.obs;
  List<String> newList = [];

  @override
  void onInit() {
    super.onInit();
    if (privilage.value == "Maintenance Engineer") {
      getEngineerComplainsByEngineer();
    } else {
      getEngineerComplains();
    }
  }

  void getEngineerComplains() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      var response =
          await http.get(Uri.parse("$apiUrl/engineer_read/$branchId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineersProblems.fromJson(json);
        engineerProblemDataList.value = data.data ?? [];
      } else {
        log('failed ${response.body}');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void getEngineerComplainsByEngineer() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt("user_id");
      var response = await http.get(
          Uri.parse("$apiUrl/engineer_read?engineer_id=$userId"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineersProblems.fromJson(json);
        engineerProblemDataList.value = data.data ?? [];
      } else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatus({required int uniqueId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response =
          await http.post(Uri.parse("$apiUrl/engineer_update/$uniqueId"),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-type': 'application/json',
              },
              body: jsonEncode(<String, dynamic>{
                "problem_solved": problem.join(","),
                "status": status.value,
                "description": descriptionController.text,
              }));
      if (response.statusCode == 200) {
        showToast(msg: "Complain updated Successfully");
        Get.back();
        privilage.value == "Maintenance Engineer"
            ? getEngineerComplainsByEngineer()
            : getEngineerComplains();
      } else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteEngineerComplain({required int uniqueId, required int complainId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http.delete(Uri.parse("$apiUrl/engineer_delete/$uniqueId/$complainId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        showToast(msg: "Complain deleted Successfully");
        Get.back();
        privilage.value == "Maintenance Engineer"
            ? getEngineerComplainsByEngineer()
            : getEngineerComplains();
      } else {
        showToastError(msg: response.body);
        log(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
