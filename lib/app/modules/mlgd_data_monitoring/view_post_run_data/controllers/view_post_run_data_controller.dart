import 'dart:convert';

import 'package:get/get.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/Model/model_run_no.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/view_post_run_data/ModelPostRunData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import 'package:http/http.dart' as http;

class ViewPostRunDataController extends GetxController {

  @override
  void onInit(){
    super.onInit();
    getPostRunNoData();
  }
  var isLoading = false.obs;
  var postRunDataList = <ModelPostRunData>[].obs;

  Future<void> getPostRunNoData() async {
    isLoading.value = true;
    var url = "$apiUrl/view_post_run_data";
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var data = ModelPostRunDataReading.fromJson(json);
      postRunDataList.value = data.data ??[];
      isLoading.value = false;
    }
    else{
      isLoading.value = false;
      postRunDataList.value = [];
    }
  }

}
