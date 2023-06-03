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
        fetchVendor().whenComplete(() => fetchManifold().whenComplete(() =>
            getGasStatus().whenComplete(() => fetchGasMonitorData(
                selectedBranchId.value, selectedGasId.value))))));
  }

  var selectedBranchId = 1.obs;
  var isLoading = false.obs;
  var isDropDownLoading = false.obs;
  var branchDataList = [].obs;

  var selectedGasId = 1.obs;
  var gasDataList = [].obs;

  var onlineGasMonitorDataList = <GasMonitor>[].obs;
  var standbyGasMonitorDataList = <GasMonitor>[].obs;
  var stockGasMonitorDataList = <GasMonitor>[].obs;
  var bottomNavigationIndex = 0.obs;

  var manifoldDataList = [].obs;
  var selectedManifoldId = 0.obs;

  var vendorDataList = [].obs;
  var selectedVendorId = 0.obs;

  var gasStatusDataList = [].obs;
  var selectedGasStatusId = 0.obs;

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
    isDropDownLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$apiUrl/get_gases"), headers: {
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      gasDataList.value = data;
      isLoading.value = false;
      isDropDownLoading.value = false;
    }
  }

  Future<List> fetchBranches() async {
    isLoading.value = true;
    isDropDownLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      branchDataList.value = jsonDecode(response.body);

      isLoading.value = false;
      isDropDownLoading.value = false;
      return branchDataList;
    } else {
      isLoading.value = false;
      isDropDownLoading.value = false;
      throw Exception('Failed to load branches');
    }
  }

  Future<void> fetchGasMonitorData(int branchId, int gasId) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(
        Uri.parse(
            "$apiUrl/get_gas_monitor?branch_id=$branchId&gases_id=$gasId"),
        headers: {'Authorization': 'Bearer $token'});
    // print(response.body);
    if (response.statusCode == 200) {
      isLoading.value = false;
      var data = ModelGasMonitor.fromJson(jsonDecode(response.body));
      onlineGasMonitorDataList.value = data.onlineGasMonitors ?? [];
      standbyGasMonitorDataList.value = data.standbyGasMonitors ?? [];
      stockGasMonitorDataList.value = data.stockGasMonitors ?? [];
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
            "$apiUrl/get_gas_monitor?branch_id=$branchId&gases_id=$gasId"),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var data = ModelGasMonitor.fromJson(jsonDecode(response.body));
      onlineGasMonitorDataList.value = data.onlineGasMonitors ?? [];
      standbyGasMonitorDataList.value = data.standbyGasMonitors ?? [];
      stockGasMonitorDataList.value = data.stockGasMonitors ?? [];
    } else {
      throw Exception();
    }
  }

  Future<void> getGasStatus() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$apiUrl/get_gas_status"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      gasStatusDataList.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchManifold() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$apiUrl/get_gas_manifold"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      manifoldDataList.value = jsonDecode(response.body);
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchVendor() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var response = await http.get(Uri.parse("$apiUrl/get_gas_vendor"),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      vendorDataList.value = jsonDecode(response.body);
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
    selectedGasStatusId.value = 0;
    selectedVendorId.value = 0;
    selectedManifoldId.value = 0;
  }

  Future<void> addGasMonitorData() async {
    fetchGasMonitorDataForCrud(selectedBranchId.value, selectedGasId.value)
        .whenComplete(() async {
      if (onlineGasMonitorDataList.isEmpty && selectedGasStatusId.value == 3) {
        showToastError(msg: "Please add online gas first ");
      } else if (onlineGasMonitorDataList.isEmpty &&
          selectedGasStatusId.value == 4) {
        showToastError(msg: "Please add online gas first ");
      } else if (standbyGasMonitorDataList.isEmpty &&
          selectedGasStatusId.value == 4) {
        showToastError(
          msg: "Please add stand by gas first ",
        );
      } else if (onlineGasMonitorDataList.isNotEmpty &&
          selectedGasStatusId.value == 2) {
        showToastError(
          msg:
              "You already have 1 online bottle , Please edit or delete the bottle first",
        );
      } else if (standbyGasMonitorDataList.isNotEmpty &&
          selectedGasStatusId.value == 3) {
        showToastError(
            msg:
                "You already have 1 stand by bottle , Please edit or delete the bottle first");
      } else {
        isLoading.value = true;
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var response = await http.post(Uri.parse("$apiUrl/add_gas_monitor"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
            body: jsonEncode(<String, String>{
              "branch_id": selectedBranchId.value.toString(),
              "gases_id": selectedGasId.value.toString(),
              "manifold_id": selectedManifoldId.value.toString(),
              "status_id": selectedGasStatusId.value.toString(),
              "vendor_id": selectedVendorId.value.toString(),
              "serial_no": addSerialNoController.text,
              "consumption": addConsumptionNoController.text,
              "operator_name": addOperatorNameController.text,
              "gas_Qty": addGasQtyNoController.text
            }));
        // print(response.body);
        if (response.statusCode == 200) {
          Get.back();
          showToast(
            msg: "Added Successfully",
          );
          clearData();
          isLoading.value = false;
          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else if (response.statusCode == 302) {
          showToastError(msg: "Serial No Already Exists");
          isLoading.value = false;
        } else {
          showToastError(
            msg: "Cannot Add ${response.statusCode}",
          );
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
      if (onlineGasMonitorDataList.isNotEmpty &&
          id != onlineGasMonitorDataList[0].gasMonitorId &&
          selectedGasStatusId.value == 2) {
        showToastError(
          msg: "Cannot Edit \nOnline gas running already",
        );
      } else if (standbyGasMonitorDataList.isNotEmpty &&
          selectedGasStatusId.value == 3 &&
          id != standbyGasMonitorDataList[0].gasMonitorId) {
        showToastError(
          msg: "Cannot Edit \n stand by gas running already",
        );
      } else {
        isLoading.value = true;
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var response = await http.put(
            Uri.parse("$apiUrl/update_gas_monitor/$id"),
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
              "status_id": (selectedGasStatusId.value == 0)
                  ? statusId
                  : selectedGasStatusId.value.toString(),
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
          showToast(
            msg: "Updated Successfully",
          );
          clearData();
          isLoading.value = false;
          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else {
          showToastError(
            msg: "Cannot Add",
          );
          isLoading.value = false;
        }
      }
    });
  }

  Future<void> updateGasMonitorStatus(
      {required int id, required int statusId}) async {
    if (onlineGasMonitorDataList.isNotEmpty &&
        id != onlineGasMonitorDataList[0].gasMonitorId &&
        statusId == 2) {
      showToastError(
        msg: "Cannot Edit \nOnline gas running already",
      );
    } else if (standbyGasMonitorDataList.isNotEmpty &&
        statusId == 3 &&
        id != standbyGasMonitorDataList[0].gasMonitorId) {
      showToastError(
        msg: "Cannot Edit \n Stand by gas running already",
      );
    } else {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var response = await http.put(
          Uri.parse("$apiUrl/update_gas_monitor_status/$id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, dynamic>{"status_id": statusId}));
      if (response.statusCode == 200) {
        showToast(
          msg: "Updated Successfully",
        );
        isLoading.value = false;
        fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
      } else {
        showToastError(
          msg: "Cannot Add",
        );
        isLoading.value = false;
      }
    }
  }

  Future<void> deleteGasMonitorData(
      int id, int branchId, int gasId, int gasStatus, int dueDays) async {
    fetchGasMonitorDataForCrud(branchId, gasId).whenComplete(() async {
      if (gasStatus == 2 && dueDays > 0) {
        Fluttertoast.showToast(
            msg: "Due date is Pending ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (stockGasMonitorDataList.isNotEmpty && gasStatus == 3) {
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
          Uri.parse("$apiUrl/delete_gas_monitor/$id"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
        );
        if (response.statusCode == 200) {
          Get.back();
          showToast(
            msg: "Deleted Successfully",
          );

          fetchGasMonitorData(selectedBranchId.value, selectedGasId.value);
        } else {
          Get.back();
          showToastError(
            msg: "Cannot delete , Please try again",
          );
          isLoading.value = false;
        }
      }
    });
  }
}
