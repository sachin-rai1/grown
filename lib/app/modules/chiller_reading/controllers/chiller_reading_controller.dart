import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/Model/model_chiller.dart';
import 'package:grown/app/modules/chiller_reading/Model/model_chiller_and_compressor.dart';
import 'package:grown/app/modules/chiller_reading/Model/model_compressor.dart';
import 'package:grown/app/modules/chiller_reading/Model/model_phase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../data/constants.dart';
import '../Model/model_process_pump.dart';

class ChillerReadingController extends GetxController {

  final formKey = GlobalKey<FormState>();


  var circulationPumpStatus1 = '0'.obs;
  var circulationPumpStatus2 = '0'.obs;

  void updatePumpStatus1(String value) {
    circulationPumpStatus1.value = value;
  }

  void updatePumpStatus2(String value) {
    circulationPumpStatus2.value = value;
  }

  final inletTemperatureController = TextEditingController();
  final outletTemperatureController = TextEditingController();
  final averageLoadController = TextEditingController();
  final compressorStatusController = TextEditingController();
  final negativeVoltageController = TextEditingController();

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

  var processPumpDataList = <ProcessPumpData>[].obs;
  var isProcessPumpLoading = false.obs;
  var processPumpStatus = [].obs;
  RxList<RxMap<String, dynamic>> processPumpStatusDataList = RxList<RxMap<String, dynamic>>();

  var chillerAndCompressorDataList = <ChillerAndCompressorData>[].obs;
  var isChillerAndCompressorLoading = false.obs;
  var chillerCompressorStatus = [].obs;
  RxList<RxMap<String, dynamic>> chillerCompressorStatusDataList = RxList<RxMap<String, dynamic>>();



  var compressorStatus = [].obs;
  var compressorDataList = <CompressorData>[].obs;
  var isCompressorLoading = false.obs;
  RxList<RxMap<String, dynamic>> compressorStatusDataList = RxList<RxMap<String, dynamic>>();
  var latestReadingId = 0.obs;
  var isUpload = false.obs;
  final processPumpPressureController = TextEditingController();

  List<TextEditingController> textControllers = [];


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchChillerAndCompressor({required int phaseId}) async{
    try {
      log(phaseId.toString());
      isChillerAndCompressorLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      final response = await http.get(Uri.parse('$apiUrl/get_chillers_by_compressor/$phaseId'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        var data = ModelChillerAndCompressor.fromJson(json);
        chillerAndCompressorDataList.value = data.data ?? [];
        int noOfOptions = chillerAndCompressorDataList.length;
        chillerCompressorStatus.value = List.generate(noOfOptions, (index) => "0");

        for (int i = 0; i < chillerAndCompressorDataList.length; i++) {
          textControllers.add(TextEditingController());
        }
        log(textControllers.length.toString());
      } else {
        chillerAndCompressorDataList.value = [];
      }
    }
    catch(e){
      log(e.toString());
    }
    finally{
      isChillerAndCompressorLoading.value = false;
    }

  }
  Map<int, Map<String, dynamic>> combinedData = {};
  List<Map<String, dynamic>> combinedJsonData = [];

  Future<void> getChillerCompressorStatus() async {
    try {
      combinedJsonData.clear();
      combinedData.clear();
      chillerCompressorStatusDataList.value = [];
      for (int index = 0; index < chillerAndCompressorDataList.length; index++) {
        chillerCompressorStatusDataList.addAll([
          RxMap<String, dynamic>({
            "chiller_id": chillerAndCompressorDataList[index].chillerId,
            "compressor_id": chillerAndCompressorDataList[index].compressorId.toString(),
            "status": chillerCompressorStatus[index].toString()
          }),
        ]);
      }


      for (var data in chillerCompressorStatusDataList) {
        var chillerId = data['chiller_id'];
        if (combinedData.containsKey(chillerId)) {
          combinedData[chillerId]?['compressors'].add({
            'compressor_id': data['compressor_id'],
            'status': data['status'],
          });
        } else {
          combinedData[chillerId] = {
            'chiller_id': chillerId,
            'compressors': [
              {
                'compressor_id': data['compressor_id'],
                'status': data['status'],
              }
            ]
          };
        }
      }
      combinedJsonData = combinedData.values.toList();
      log(combinedJsonData[0]["chiller_name"].toString());

    }
    catch(e){
      log(e.toString());
      throw Exception();
    }
  }

  void clearData(){
    inletTemperatureController.clear();
    outletTemperatureController.clear();
    averageLoadController.clear();
    compressorStatusController.clear();
    negativeVoltageController.clear();
    processPumpPressureController.clear();

  }

  Future<void> fetchData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var branchId = prefs.getInt("user_branch_id");
      await fetchBranches();
      await fetchPhases(branchId: branchId!);
      await fetchProcessPump(phaseId: phaseDataList[0].phaseId!);
      await fetchChiller(phaseId: phaseDataList[0].phaseId!);
      await fetchCompressor(chillerId: chillerDataList[0].chillerId!);
      await fetchChillerAndCompressor(phaseId: phaseDataList[0].phaseId!);

      await getCompressorStatus();
      await getProcessPumpStatus();

      selectedBranchId.value =branchId;
      selectedChillerId.value = chillerDataList[0].chillerId!;
      selectedPhaseId.value = phaseDataList[0].phaseId!;


    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> fetchProcessPump({required int phaseId}) async{
    try {
      isProcessPumpLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      final response = await http.get(Uri.parse('$apiUrl/view_process_pump?phase_id_fk=$phaseId'), headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        var data = ModelProcessPump.fromJson(json);
        processPumpDataList.value = data.data ?? [];
        int noOfOptions = processPumpDataList.length;
        processPumpStatus.value = List.generate(noOfOptions, (index) => "0");

      } else {
        processPumpDataList.value = [];
      }
    }
    catch(e){
      log(e.toString());
    }
    finally{
      isProcessPumpLoading.value = false;
    }

  }

  Future<void> getProcessPumpStatus() async {
    processPumpStatusDataList.value = [];
    for (int index = 0; index < processPumpDataList.length; index++) {
      processPumpStatusDataList.addAll([
        RxMap<String, dynamic>({
          "process_pump_id_fk": processPumpDataList[index].cppId.toString(),
          "status": processPumpStatus[index].toString()
        }),
      ]);
    }
  }

  Future<void> getCompressorStatus() async {
     compressorStatusDataList.value = [];
    for (int index = 0; index < compressorDataList.length; index++) {
      compressorStatusDataList.addAll([
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

  Future<void> addChillerReadingData({required int chillerId , required String chillerName ,required int i}) async {
    try {
      isUpload.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt("user_branch_id");
      final response = await http.post(Uri.parse('$apiUrl/add_chiller_reading'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json'
          },
          body: jsonEncode(<dynamic, String>{
            "branch_id": branchId.toString(),
            "phase_id": selectedPhaseId.value.toString(),
            "inlet_temperature": inletTemperatureController.text,
            "outlet_temperature": outletTemperatureController.text,
            "process_pump_pressure": processPumpPressureController.text,
            "chiller_id": chillerId.toString(),
            "average_load": averageLoadController.text,
            "circulation_pump_1_status": circulationPumpStatus1.value,
            "circulation_pump_2_status": circulationPumpStatus2.value
          }));

      var jsonData = jsonDecode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        latestReadingId.value = jsonData['reading_id'];
        insertDataToAPI(i:i, readingId: latestReadingId.value);
      } else {
        log(response.statusCode.toString());
        showToastError(msg: jsonData["message"].toString());
      }
    }
    catch(e){
      throw Exception();
    }
    finally{
      isUpload.value = false;
      showToast(msg: "$chillerName Uploaded");
    }
  }

  Future<void> insertDataToAPI({required int readingId , required int i}) async {
    try {
        for(int j =0 ; j<combinedJsonData[i]["compressors"].length ; j++){
          await addCompressorData(chillerReadingId: readingId, data: combinedJsonData[i]["compressors"][j]);
        }

      for(int i=0; i<processPumpDataList.length; i++){
          await addProcessPumpData(chillerReadingId: readingId, data: processPumpStatusDataList[i]);
      }
    }
    catch(e){
      showToastError(msg: e);
    }
  }

  Future<void> addProcessPumpData({required int chillerReadingId, required var data}) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.post(
        Uri.parse('$apiUrl/add_process_pump_reading/$chillerReadingId'),
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