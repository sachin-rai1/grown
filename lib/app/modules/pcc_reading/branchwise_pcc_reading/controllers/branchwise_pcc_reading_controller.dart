import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../datewise_pcc_reading/Model/view_model.dart';
import 'package:http/http.dart' as http;




class BranchwisePccReadingController extends GetxController {
  var isLoading = false.obs;
  var isLoadings = false.obs;
  var pccDataList = <Report> [].obs;
  var branchDataList = [].obs;
  var selectedBranchId = 0.obs;
  var selectedBranch =0.obs;
  var branchIdFk = 0.obs;


  var selectedBranchIdFk = 0.obs;
  var selectedPccIdFk = 0.obs;


  final aACB = TextEditingController();
  final mMFM = TextEditingController();
  final neVolt = TextEditingController();
  final ryVolt = TextEditingController();
  final ybVolt = TextEditingController();
  final brVolt = TextEditingController();
  final rnVolt = TextEditingController();
  final ynVolt = TextEditingController();
  final bnVolt = TextEditingController();
  final reVolt = TextEditingController();
  final yeVolt = TextEditingController();
  final beVolt = TextEditingController();
  final remark = TextEditingController();
  final pPowerFactorMFM = TextEditingController();

  var meter = "0".obs;
  var light = "0".obs;
  var fan = "0".obs;
  List<Map<String, dynamic>> jsonList = [];

  var selectedBranchName = ''.obs;




//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchBranches();
    selectedBranch.value = branchDataList[0]["branch_id"];
    selectedBranchName.value = branchDataList[0]["branch_name"];
    await getPccData(branchId: selectedBranch.value);
  }


  Future<void> getPccData({required var branchId}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response =await http.get(Uri.parse(
          "$apiUrl/pcc_daily_reading_read?branch_id_fk=$branchId"
      ),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          }
      );

      isLoadings.value = true;
      if (response.statusCode == 200) {

        var jsonDataList = jsonDecode(response.body);
        var data = ModelPccReport.fromJson(jsonDataList);
        pccDataList.value = data.report ?? [];

        jsonList = [jsonDataList];

        isLoading.value = false;


      }
      else
      {
        isLoading.value = false;
        pccDataList.value = [];
        jsonList=[];
      }
    }
    finally
    {
      isLoadings.value = false;
    }

  }



  Future<void> convertToExcel(List<Map<String, dynamic>> jsonList) async {
    bool excelSuccess = await writeToFile(jsonList);
    if (excelSuccess) {
      log("Excel file created successfully.");
      showToast(msg: "File Saved In Downloads OR Documents Folder");


    } else {
      log("Failed to create Excel file.");
      showToastError(msg: "File Can't Save Try Again ");
    }
  }
  Future<bool> writeToFile(List<Map<String, dynamic>> data) async {
    try {
      var excel = Excel.createExcel();
      var sheet = excel['Sheet1'];

      //write the header
      sheet.appendRow(data[0]["Report"][0].keys.toList());

      // Write the data
      for(int i = 0 ; i<data[0]["Report"].length ; i++){
        sheet.appendRow(data[0]["Report"][i].values.toList());
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

        String filePath = '${directory!.path}/$selectedBranchName PccReadingBranchWise${DateTime.now().microsecondsSinceEpoch}.xlsx';
        var file = File(filePath);
        await file.writeAsBytes(excel.encode()!);
      }
      return true;
    } catch (e) {
      log("Error creating Excel file: $e");
      return false;
    }
  }

//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______//_______



  void updatePccData ({
    required int id,
    required int branchIdFk,
    required int pccIdFk,

  })
  async {
    isLoading.value = true;
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      final response = await http.put(
        Uri.parse(
            "$apiUrl/pcc_daily_reading_update/$id"
        ),
        headers: {
          // compulsory to set the header in  post API calling......
          'Authorization' : 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>
        {
          "load_amp_acb":aACB.text,
          "load_amp_mfm":mMFM.text,
          "power_factor_mfm":pPowerFactorMFM.text,
          "all_meter_status_pcc":meter.value,     //(meterStatus.value == "")? Meter.value :meterStatus.value,
          "all_light_status_pcc":light.value,     //(lightStatus.value == "") ? Light.value : lightStatus.value,
          "all_exhaust_fan_status":fan.value,   //(fanStatus.value == "") ? Fan.value : fanStatus.value,
          "n_e_volt":neVolt.text,
          "r_y_volt":ryVolt.text,
          "y_b_volt":ybVolt.text,
          "b_r_volt":brVolt.text,
          "r_n_volt":rnVolt.text,
          "y_n_volt":ynVolt.text,
          "b_n_volt":bnVolt.text,
          "r_e_volt":reVolt.text,
          "y_e_volt":yeVolt.text,
          "b_e_volt":beVolt.text,
          "remark_If_any":remark.text,
          "branch_id_fk":(selectedBranchIdFk.value == 0)? branchIdFk : selectedBranchIdFk.value,
          "user_id_fk":"21",
          "pcc_id_fk":(selectedPccIdFk.value == 0)? pccIdFk : selectedPccIdFk.value,
        }
        ),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        getPccData(branchId: selectedBranchId.value);
        showToast(msg: "Data Updated Successfully");

      }
      else {
      }
    }

    finally{
      isLoading.value = false;
    }

  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  Future<void> fetchBranches() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    isLoading.value = true;
    final response = await http.get(Uri.parse('$apiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        branchDataList.value = jsonDecode(response.body);
        log(branchDataList[0]["branch_id"].toString());
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      throw Exception(response.body);
    }
  }



//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  deletePccData({required int id}) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    isLoading.value = true;
    final response = await http.delete(Uri.parse(
        '$apiUrl/pcc_daily_reading_delete/$id'
    ),
        headers: {'Authorization': 'Bearer $token',}
    );
    if (response.statusCode == 200) {
      getPccData(branchId: selectedBranchId.value);
      Get.back();
      isLoading.value = false;
    } else {
      showToastError(msg: "Can't Delete :  ${response.statusCode}");
      isLoading.value = false;

    }
  }


}
