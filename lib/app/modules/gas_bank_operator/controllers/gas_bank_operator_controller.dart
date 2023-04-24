import 'dart:convert';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../ModelGasMonitorData.dart';

class GasBankOperatorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchBranches().whenComplete(() => fetchGases());
  }

  var selectedBranchId = 0.obs;
  var isLoading = false.obs;
  var branchData = [].obs;

  var selectedGasId = 0.obs;
  var gasData = [].obs;

  var onlineGasMonitorData = <GasMonitor>[].obs;
  var standbyGasMonitorData = <GasMonitor>[].obs;
  var stockGasMonitorData = <GasMonitor>[].obs;
  var bottomNavigationIndex = 0.obs;

  Future<void> fetchGases() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$empManagementApiUrl/get_gases"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      gasData.value = data;
      isLoading.value = false;
    }
  }

  Future<List> fetchBranches() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$empManagementApiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      branchData.value = jsonDecode(response.body);

      isLoading.value = false;
      return branchData;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  void fetchGasMonitorData(int branchId, int gasId) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse(
            "$empManagementApiUrl/get_gas_monitor?branch_id=$branchId&gases_id=$gasId"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var data = ModelGasMonitor.fromJson(jsonDecode(response.body));
      onlineGasMonitorData.value = data.onlineGasMonitors ?? [];
      standbyGasMonitorData.value = data.standbyGasMonitors ?? [];
      stockGasMonitorData.value = data.stockGasMonitors ?? [];
    } else {
      throw Exception();
    }
  }
}
