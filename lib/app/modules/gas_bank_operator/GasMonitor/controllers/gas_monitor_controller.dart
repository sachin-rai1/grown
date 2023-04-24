import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../ModelGasMonitorData.dart';

class GasMonitorController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchBranches().whenComplete(() => fetchGases().whenComplete(() =>
        fetchVendor().whenComplete(
            () => fetchManifold().whenComplete(() => getGasStatus()))));
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

  var manifoldData = [].obs;
  var selectedManifoldId = 0.obs;

  var vendorData = [].obs;
  var selectedVendorId = 0.obs;

  var gasStatus = [].obs;
  var selectedGasStatus = 0.obs;

  final addSerialNoController = TextEditingController();
  final addConsumptionNoController = TextEditingController();
  final addGasQtyNoController = TextEditingController();
  final addOperatorNameController = TextEditingController();

  final updateSerialNoController = TextEditingController();
  final updateConsumptionNoController = TextEditingController();
  final updateGasQtyNoController = TextEditingController();
  final updateOperatorNameController = TextEditingController();

  Future<void> fetchGases() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response =
        await http.get(Uri.parse("$empManagementApiUrl/get_gases"), headers: {
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
    final response =
        await http.get(Uri.parse('$empManagementApiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      branchData.value = jsonDecode(response.body);

      isLoading.value = false;
      return branchData;
    } else {
      isLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  Future<void> fetchGasMonitorData(int branchId, int gasId) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse(
            "$empManagementApiUrl/get_gas_monitor?branch_id=$branchId&gases_id=$gasId"),
        headers: {'Authorization': 'Bearer $token'});
    // print(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      var data = ModelGasMonitor.fromJson(jsonDecode(response.body));
      onlineGasMonitorData.value = data.onlineGasMonitors ?? [];
      standbyGasMonitorData.value = data.standbyGasMonitors ?? [];
      stockGasMonitorData.value = data.stockGasMonitors ?? [];
    } else {
      isLoading.value = false;
      throw Exception();
    }
  }

  Future<void> fetchGasMonitorDataForCrud(int branchId, int gasId) async {
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

  Future<void> getGasStatus() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse("$empManagementApiUrl/get_gas_status"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      gasStatus.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchManifold() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse("$empManagementApiUrl/get_gas_manifold"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      manifoldData.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchVendor() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse("$empManagementApiUrl/get_gas_vendor"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      vendorData.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  void clearData() {
    addSerialNoController.clear();
    addConsumptionNoController.clear();
    addGasQtyNoController.clear();
    addOperatorNameController.clear();
    updateSerialNoController.clear();
    updateConsumptionNoController.clear();
    updateGasQtyNoController.clear();
    updateOperatorNameController.clear();
    selectedGasStatus.value = 0;
    selectedVendorId.value = 0;
    selectedManifoldId.value = 0;
  }

  Future<void> addGasMonitorData() async {
    fetchGasMonitorDataForCrud(selectedBranchId.value, selectedGasId.value)
        .whenComplete(() async {
      if (onlineGasMonitorData.isEmpty && selectedGasStatus.value == 3) {
        Fluttertoast.showToast(
            msg: "Please add online gas first ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (onlineGasMonitorData.isEmpty && selectedGasStatus.value == 4) {
        Fluttertoast.showToast(
            msg: "Please add online gas first ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (standbyGasMonitorData.isEmpty &&
          selectedGasStatus.value == 4) {
        Fluttertoast.showToast(
            msg: "Please add stand by gas first ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (onlineGasMonitorData.isNotEmpty &&
          selectedGasStatus.value == 2) {
        Fluttertoast.showToast(
            msg:
                "You already have 1 online bottle , Please edit or delete the bottle first",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (standbyGasMonitorData.isNotEmpty &&
          selectedGasStatus.value == 3) {
        Fluttertoast.showToast(
            msg:
                "You already have 1 stand by bottle , Please edit or delete the bottle first",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        isLoading.value = true;
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var response = await http.post(
            Uri.parse("$empManagementApiUrl/add_gas_monitor"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(<String, String>{
              "branch_id": selectedBranchId.value.toString(),
              "gases_id": selectedGasId.value.toString(),
              "manifold_id": selectedManifoldId.value.toString(),
              "status_id": selectedGasStatus.value.toString(),
              "vendor_id": selectedVendorId.value.toString(),
              "serial_no": addSerialNoController.text,
              "consumption": addConsumptionNoController.text,
              "operator_name": addOperatorNameController.text,
              "gas_Qty": addGasQtyNoController.text
            }));
        // print(response.body);
        if (response.statusCode == 200) {
          Get.back();
          Fluttertoast.showToast(
              msg: "Added Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          clearData();
          isLoading.value = false;
          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else if (response.statusCode == 302) {
          Fluttertoast.showToast(
              msg: "Serial No Already Exists",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isLoading.value = false;
        } else {
          Fluttertoast.showToast(
              msg: "Cannot Add ${response.statusCode}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isLoading.value = false;
        }
      }
    });
  }

  Future<void> updateGasMonitorData(
      int id,
      String serialNo,
      String consumption,
      String operatorName,
      String gasQty,
      int branchId,
      int gasId,
      int statusId,
      int vendorId,
      int manifoldId) async {
    fetchGasMonitorDataForCrud(branchId, gasId).whenComplete(() async {
      if (onlineGasMonitorData.isNotEmpty &&
          id != onlineGasMonitorData[0].gasMonitorId &&
          selectedGasStatus.value == 2) {
        Fluttertoast.showToast(
            msg: "Cannot Edit \nOnline gas running already",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (standbyGasMonitorData.isNotEmpty &&
          selectedGasStatus.value == 3 &&
          id != standbyGasMonitorData[0].gasMonitorId) {
        Fluttertoast.showToast(
            msg: "Cannot Edit \n stand by gas running already",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        isLoading.value = true;
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var response = await http.put(
            Uri.parse("$empManagementApiUrl/update_gas_monitor/$id"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(<String, dynamic>{
              "branch_id": branchId,
              "gases_id": gasId,
              "manifold_id": (selectedManifoldId.value == 0)
                  ? manifoldId
                  : selectedManifoldId.value.toString(),
              "status_id": (selectedGasStatus.value == 0)
                  ? statusId
                  : selectedGasStatus.value.toString(),
              "vendor_id": (selectedVendorId.value == 0)
                  ? vendorId
                  : selectedVendorId.value.toString(),
              "serial_no": (updateSerialNoController.text == "")
                  ? serialNo
                  : updateSerialNoController.text,
              "consumption": (updateConsumptionNoController.text == "")
                  ? consumption
                  : updateConsumptionNoController.text,
              "operator_name": (updateOperatorNameController.text == "")
                  ? operatorName
                  : updateOperatorNameController.text,
              "gas_Qty": (updateGasQtyNoController.text == "")
                  ? gasQty
                  : updateGasQtyNoController.text,
            }));
        // print(response.body);
        if (response.statusCode == 200) {
          Get.back();
          Fluttertoast.showToast(
              msg: "Updated Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          clearData();
          isLoading.value = false;
          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else {
          Fluttertoast.showToast(
              msg: "Cannot Add",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isLoading.value = false;
        }
      }
    });
  }

  Future<void> deleteGasMonitorData(
      int id, int branchId, int gasId, int gasStatus, DateTime dueDate) async {
    fetchGasMonitorDataForCrud(branchId, gasId).whenComplete(() async {
      if (standbyGasMonitorData.isNotEmpty &&
          gasStatus == 2 &&
          dueDate.compareTo(DateTime.now().add(const Duration(days: 1))) >= 0) {
        Fluttertoast.showToast(
            msg: "Please delete stand by gas first Or Due date is Pending ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (stockGasMonitorData.isNotEmpty && gasStatus == 3) {
        Fluttertoast.showToast(
            msg: "Please delete stock gas first ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        isLoading.value = true;
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        var response = await http.delete(
          Uri.parse("$empManagementApiUrl/delete_gas_monitor/$id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          Get.back();

          Fluttertoast.showToast(
              msg: "Deleted Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else {
          Get.back();
          Fluttertoast.showToast(
              msg: "Cannot delete , Please try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isLoading.value = false;
        }
      }
    });
  }
}
