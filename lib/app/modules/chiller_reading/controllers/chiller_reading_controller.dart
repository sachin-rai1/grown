import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelChiller.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelCompressor.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelPhase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../data/constants.dart';

class ChillerReadingController extends GetxController {
  final inletTemperatureController = TextEditingController();
  final outletTemperatureController = TextEditingController();
  final averageLoadController = TextEditingController();
  final compressorStatusController = TextEditingController();
  final negativeVoltageController = TextEditingController();

  var compressorStatus = [].obs;
  var isLoading = false.obs;
  var branchDataList = [].obs;
  var selectedBranchId = 0.obs;
  var selectedBranch = "".obs;

  var selectedPhase = "".obs;
  var selectedPhaseId = 0.obs;
  var phaseDataList = <PhaseData>[].obs;

  var chillerDataList = <ChillerData>[].obs;
  var selectedChillerId = 0.obs;
  var selectedChiller = "".obs;
  var isChillerLoading = false.obs;

  var compressorDataList = <CompressorData>[].obs;
  var isCompressorLoading = false.obs;

  var latestReadingId = 0.obs;
  RxList<RxMap<String, dynamic>> dataList = RxList<RxMap<String, dynamic>>();
  var isUpload = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void clearData(){
    inletTemperatureController.clear();
    outletTemperatureController.clear();
    averageLoadController.clear();
    compressorStatusController.clear();
    negativeVoltageController.clear();
  }

  Future<void> fetchData() async {
    try {
      await fetchBranches();
      await fetchPhases(branchId: branchDataList[0]["branch_id"]);
      await fetchChiller(phaseId: phaseDataList[0].phaseId!);
      await fetchCompressor(chillerId: chillerDataList[0].chillerId!);
      await getCompressorStatus();

      selectedBranchId.value = branchDataList[0]["branch_id"];
      selectedChillerId.value = chillerDataList[0].chillerId!;
      selectedPhaseId.value = phaseDataList[0].phaseId!;


    } catch (e) {
      log(e.toString());
    }
  }

   getCompressorStatus() async {
     dataList.value = [];
    for (int index = 0; index < compressorDataList.length; index++) {
      dataList.addAll([
        RxMap<String, dynamic>({
          "compressor_id": compressorDataList[index].compressorId.toString(),
          "status": compressorStatus[index].toString()
        }),
      ]);
    }

  }

  Future<void> fetchBranches() async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/branches'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      for (int i = 0; i < data.length; i++) {
        branchDataList.value = jsonDecode(response.body);
      }
      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      throw Exception(response.body);
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

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = Modelphase.fromJson(json);
      phaseDataList.value = data.data ?? [];

      isLoading.value = false;
    } else {
      isLoading.value = false;
      log(response.body.toString());
      phaseDataList.value = [];
      selectedPhaseId.value = 0;
      log(selectedPhaseId.toString());
    }
  }

  Future<void> fetchChiller({required int phaseId}) async {
    isChillerLoading.value = true;
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
      chillerDataList.value = [];
      selectedChillerId.value = 0;
    }
  }

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
      int noOfOptions = compressorDataList.length;
      compressorStatus.value = List.generate(noOfOptions, (index) => "0");

      isCompressorLoading.value = false;
    } else {
      isCompressorLoading.value = false;
      compressorDataList.value = [];
    }
  }

  Future<void> addChillerReadingData() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(Uri.parse('$apiUrl/add_chiller_reading'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(<dynamic, String>{
          "branch_id": selectedBranchId.value.toString(),
          "phase_id": selectedPhaseId.value.toString(),
          "inlet_temperature": inletTemperatureController.text,
          "outlet_temperature": outletTemperatureController.text,
          "chiller_id": selectedChillerId.value.toString(),
          "average_load": averageLoadController.text,
        }));

    var jsonData = jsonDecode(response.body);
    log(jsonData.toString());
    if (response.statusCode == 200) {
      latestReadingId.value = jsonData['reading_id'];
      clearData();
    } else {
      showToastError(msg: jsonData["message"].toString());
    }
  }

  Future<void> insertDataToAPI({required int readingId}) async {
    try {
      isUpload.value = true;
      for (int i = 0; i < compressorDataList.length; i++) {
        await addCompressorData(chillerReadingId: readingId, data: dataList[i]);
      }
    }
    catch(e){
      showToastError(msg: e);
    }
    finally{
      showToast(msg: "Uploaded");
      isUpload.value = false;
    }

  }

  Future<void> addCompressorData({required int chillerReadingId, required var data}) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(
        Uri.parse('$apiUrl/add_chiller_compressor_reading/$chillerReadingId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-type': 'application/json'
        },
        body: jsonEncode(data));
    var jsonData = jsonDecode(response.body);
    log(jsonData["message"].toString());

    if (response.statusCode == 200) {
      log("uploaded");
    } else {
      showToastError(msg: jsonData["message"].toString());
    }
  }
}
