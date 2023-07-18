import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Model/pccModel.dart';
import '../../../../data/constants.dart';

class PccDataController extends GetxController {
  var isLoadings = false.obs;
  var pccNameList = <Pccmodel> [].obs;
  var selectedBranchIdFk = 0.obs;
  var selectedUserIdFk = 0.obs;

  final pccNameController = TextEditingController();
  final upDatePccNameController = TextEditingController();


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________


  Future<void> pccInsertData()
  async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');
      var branchId = prefs.getInt('user_branch_id');
      isLoadings.value = true;
      final response = await http.post(
        Uri.parse
          ("$apiUrl/pcc_tb_insert"),

        headers: {
          'Authorization' : 'Bearer $token',                                        // complsary to set the header in  post API calling......
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>
        {
          "pcc_name":pccNameController.text,
          "branch_id_fk":branchId,
          "user_id_fk":userId,
        }
        ),
      );

      if (response.statusCode == 200) {
        showToast(msg: "Pcc Added Successfully");
        getPccName();
      }
      else {
        log(response.body);
        showToast(msg: "No Data inserted ${response.statusCode}");
      }
    }

    finally{
      isLoadings.value = false;
    }
  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________


  void updatePccName ({required int id })
  async {
    isLoadings.value = true;
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      var userId = prefs.getInt('user_id');
      final response = await http.put(
        Uri.parse(
            "$apiUrl/pcc_tb_update/$id"
        ),
        headers: {
          // compulsory to set the header in  post API calling......
          'Authorization' : 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{

          "pcc_name":upDatePccNameController.text,
          "branch_id_fk": branchId,
          "user_id_fk": userId

        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        Get.back();
        getPccName();
      }
      else {
      }
    }
    finally{
      isLoadings.value = false;
    }

  }



//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________

  @override
  void onInit()
  {
    super.onInit();
    getPccName();
  }
  Future <void> getPccName() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      isLoadings.value = true;
      var response = await http.get(Uri.parse("$apiUrl/pcc_tb_read?branch_id_fk=$branchId"),
          headers: {
            'Authorization' : 'Bearer $token',
            'Content-type': 'application/json',
          }
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelPccList.fromJson(json);
        pccNameList.value = data.data ?? [];

      }
      else {

        showToast(msg: "No Data Found${response.statusCode}");
      }
    }
    finally {
      isLoadings.value = false;

    }

  }


//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________//_____________



  deletePccData({required int id})
  async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    isLoadings.value = true;
    final response = await http.delete(Uri.parse("$apiUrl/pcc_tb_delete/$id"),
        headers: {'Authorization': 'Bearer $token',}

    );
    if (response.statusCode == 200) {
      getPccName();
      Get.back();
      isLoadings.value = false;

    } else {
      showToastError(msg: "Can't Delete :  ${response.statusCode}");
      isLoadings.value = false;

    }
  }
}
