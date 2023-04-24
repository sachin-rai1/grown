import 'dart:convert';
import 'dart:developer';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';

class ViewMlgdDataDateWiseController extends GetxController {
  List data = [].obs;
  var isLoading = false.obs;

  getData(startDate) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      isLoading.value = true;
      var response = await http.get(
        Uri.parse("$empManagementApiUrl/view_mlgd_data?startDate=$startDate"),
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Bearer $token"
        },
      );
      log(response.statusCode.toString());
      if (response.statusCode == 200) {

          data = jsonDecode(response.body);
          log(data.length.toString());
          isLoading.value = false;

      } else {
          data = [];
          log(data.length.toString());
          isLoading.value = false;
        log("Error: ${response.statusCode}");
        // Handle the error response here
      }
    } catch (e) {
      isLoading.value = false;
      log("Error: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    getData(formatted);
  }

  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;
}
