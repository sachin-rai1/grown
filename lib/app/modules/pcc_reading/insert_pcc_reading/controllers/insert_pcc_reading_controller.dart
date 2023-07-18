import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/constants.dart';
import '../../Model/pccModel.dart';

class InsertPccReadingController extends GetxController {
  var isLoadings = false.obs;
  var pccNameList = <Pccmodel>[].obs;
  var selectedPccId = 0.obs;
  var branchIdFk = 0.obs;
  var useridFk = 0.obs;
  final formKey = GlobalKey<FormState>();


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

//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  @override
  Future<void> onInit() async {
    super.onInit();
    getPccData();
  }

  Future<void> getPccData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      isLoadings.value = true;
      var response = await http
          .get(Uri.parse("$apiUrl/pcc_tb_read?branch_id_fk=$branchId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPccList.fromJson(json);
        pccNameList.value = data.data ?? [];
        selectedPccId.value =  pccNameList[0].pccId!;
        log(json.toString());

      } else {
        log("Error : ${response.body}");
      }
    } finally {
      isLoadings.value = false;
    }
  }

//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  Future<void> insertData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');
      var branchId = prefs.getInt('user_branch_id');
      final response = await http.post(
        Uri.parse("$apiUrl/pcc_daily_reading_insert"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          "load_amp_acb": aACB.text,
          "load_amp_mfm": mMFM.text,
          "power_factor_mfm": pPowerFactorMFM.text,
          "all_meter_status_pcc": meter.value,
          "all_light_status_pcc": light.value,
          "all_exhaust_fan_status": fan.value,
          "n_e_volt": neVolt.text,
          "r_y_volt": ryVolt.text,
          "y_b_volt": ybVolt.text,
          "b_r_volt": brVolt.text,
          "r_n_volt": rnVolt.text,
          "y_n_volt": ynVolt.text,
          "b_n_volt": bnVolt.text,
          "r_e_volt": reVolt.text,
          "y_e_volt": yeVolt.text,
          "b_e_volt": beVolt.text,
          "remark_If_any": remark.text,
          "branch_id_fk": branchId,
          "user_id_fk": userId,
          "pcc_id_fk":selectedPccId.value,
        }),
      );
      if (response.statusCode == 200) {
        showToast(msg: "Data inserted Successfully");
        clearData();
      } else {
        showToastError(msg: "No Data inserted ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  clearData(){
    aACB.clear();
    mMFM.clear();
    pPowerFactorMFM.clear();
    neVolt.clear();
    ryVolt.clear();
    ybVolt.clear();
    brVolt.clear();
    rnVolt.clear();
    ynVolt.clear();
    bnVolt.clear();
    reVolt.clear();
    yeVolt.clear();
    beVolt.clear();
    remark.clear();
  }
}
