import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/constants.dart';
import '../Model/view_model.dart';

class DatewisePccReadingController extends GetxController {

  var isLoading = false.obs;
  var pccDataList = <Report> [].obs;
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

  var meter = "0 ".obs;
  var light = " 0".obs;
  var fan = " 0".obs;








//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______//______

  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;

  @override
  void onInit() {
    var date =DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    selectedDate.value = formatted;
    getPccData(selectedDate : formatted);
    super.onInit();
  }


  void getPccData({required var selectedDate}) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response =await http.get(Uri.parse("$apiUrl/pcc_daily_reading_read?created_on=$selectedDate"),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          }
      );
      isLoading.value = true;
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPccReport.fromJson(json);
        pccDataList.value = data.report ?? [];
        isLoading.value = false;
      }
      else
      {
        isLoading.value = false;
        pccDataList.value = [];

      }
    }
    catch (e)
    {
      log(e.toString());
    }
    finally
    {
      isLoading.value = false;
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
        getPccData(selectedDate: selectedDate.value);
      }
      else {
      }
    }
    catch (e) {
      log(e.toString());
    }
    finally{
      isLoading.value = false;
    }

  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  void clearData(){}


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

      getPccData(selectedDate: selectedDate.value);
      Get.back();
      isLoading.value = false;
    } else {
      showToastError(msg: "Can't Delete :  ${response.statusCode}");
      isLoading.value = false;

    }
  }
}