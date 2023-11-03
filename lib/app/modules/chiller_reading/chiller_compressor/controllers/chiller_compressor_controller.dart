import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../Model/model_chiller.dart';
import '../../Model/model_compressor.dart';
import '../../Model/model_phase.dart';
import '../../controllers/chiller_reading_controller.dart';

class ChillerCompressorController extends GetxController {
  var isLoading = false.obs;
  var isChillerLoading = false.obs;
  var phaseDataList = <PhaseData>[].obs;
  var chillerDataList = <ChillerData>[].obs;
  var selectedChillerId = 0.obs;
  var selectedChiller = "".obs;
  var selectedPhaseId = 0.obs;
  var selectedBranchId = 0.obs;
  final chillerReadingController = Get.put(ChillerReadingController());
  final compressorNameController = TextEditingController();
  final updateCompressorNameController = TextEditingController();

  var selectedBranchName = "".obs;
  var selectedPhaseName = "".obs;

  @override
  void onInit() {
    super.onInit();
    selectedBranchName.value = chillerReadingController.branchDataList[0]["branch_name"];
    fetchData();
  }



  Future<void> fetchData() async {
    try {
      await fetchPhases(branchId: chillerReadingController.branchDataList[0]["branch_id"]);
      await fetchChiller(phaseId: phaseDataList[0].phaseId!);

      await fetchCompressor(chillerId: chillerDataList[0].chillerId!).whenComplete(() {
        selectedPhaseName.value = phaseDataList[0].phaseName!;
        selectedChillerId.value = chillerDataList[0].chillerId!;
        selectedPhaseId.value = phaseDataList[0].phaseId!;
      });

    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchPhases({required int branchId}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('$apiUrl/get_chiller_phase/$branchId'), headers: {
      'Authorization': 'Bearer $token',
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = Modelphase.fromJson(json);
      phaseDataList.value = data.data ?? [];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      phaseDataList.value = [];
    }
  }

  var isCompressorLoading = false.obs;
  var compressorDataList = <CompressorData>[].obs;

  Future<void> fetchCompressor({required int chillerId}) async {
    isCompressorLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http
        .get(Uri.parse('$apiUrl/get_compressor/$chillerId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelCompressor.fromJson(json);
      compressorDataList.value = data.compressor ?? [];
      isCompressorLoading.value = false;
    } else {
      isCompressorLoading.value = false;
      compressorDataList.value = [];
    }
  }

  Future<void> fetchChiller({required int phaseId}) async {
    isChillerLoading.value = true;
    chillerDataList.value = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response =
        await http.get(Uri.parse('$apiUrl/get_chiller/$phaseId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChiller.fromJson(json);
      chillerDataList.value = data.data ?? [];
      isChillerLoading.value = false;
    } else {
      isChillerLoading.value = false;
    }
  }

  Future<void> addCompressor() async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_compressor'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          "chiller_id": selectedChillerId.value.toString(),
          "compressor_name": compressorNameController.text
        }));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      fetchCompressor(chillerId: selectedChillerId.value);
      compressorNameController.clear();
      showToast(msg: "Compressor Added Successfully");
      isChillerLoading.value = false;
    } else if (response.statusCode == 400) {
      showToastError(msg: json["message"]);
      isChillerLoading.value = false;
    }
  }

  Future<void> updateCompressor({required int compressorId}) async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.put(
        Uri.parse('$apiUrl/update_compressor/$compressorId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          "compressor_name": updateCompressorNameController.text
        }));

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchCompressor(chillerId: selectedChillerId.value);
      showToast(msg: "Compressor Updated Successfully");
      updateCompressorNameController.clear();
      isChillerLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
    }
  }

  Future<void> deleteCompressor({required int compressorId}) async {
    isChillerLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.delete(
      Uri.parse('$apiUrl/delete_compressor/$compressorId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json'
      },
    );

    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Get.back();
      fetchCompressor(chillerId: selectedChillerId.value);
      showToast(msg: "Compressor Deleted Successfully");
      isChillerLoading.value = false;
    } else {
      isChillerLoading.value = false;
      showToastError(msg: "Can't Delete ,Other Data Already Exists");
    }
  }
}
