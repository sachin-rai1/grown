import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelChillerCompressorReading.dart';
import 'package:grown/app/modules/chiller_reading/Model/ModelChillerReading.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../chiller_compressor/Model/ModelChillerCompressor.dart';

class DatewiseChillerReadingController extends GetxController {
  Rx<String> selectedDate = DateTime.now().toString().obs;
  dynamic formatted;
  var isLoading = false.obs;
  var chillerReadingDataList = <ChillerReadingData>[].obs;
  var chillerCompressorDataList = <ChillerCompressorData>[].obs;
  var isCompressorLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    var date = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(date);
    fetchChillerReading(selectedDate: formatted).whenComplete(() => main());
  }



  void main() {
    const jsonData = '''
    {
    "children": [       
        {
            "ccr_id": 7,
            "compressor_id": 15,
            "cr_id": 69,
            "status": 0
        },
        {
            "ccr_id": 8,
            "compressor_id": 17,
            "cr_id": 69,
            "status": 0
        },
        {
            "ccr_id": 9,
            "compressor_id": 12,
            "cr_id": 70,
            "status": 1
        },
        {
            "ccr_id": 10,
            "compressor_id": 16,
            "cr_id": 70,
            "status": 1
        },
        {
            "ccr_id": 11,
            "compressor_id": 12,
            "cr_id": 71,
            "status": 0
        },
        {
            "ccr_id": 12,
            "compressor_id": 16,
            "cr_id": 71,
            "status": 1
        }
    ],
    "parent": [
        {
            "average_load": 20,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 100,
            "outlet_temperature": 100,
            "phase_id": 9,
            "reading_id": 61
            
        },
        {
            "average_load": 120,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 100,
            "outlet_temperature": 150,
            "phase_id": 9,
            "reading_id": 62
            
        },
        {
            "average_load": 400,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 42,
            "outlet_temperature": 25,
            "phase_id": 9,
            "reading_id": 65
            
        },
        {
            "average_load": 0,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 21,
            "outlet_temperature": 16,
            "phase_id": 9,
            "reading_id": 66
            
        },
        {
            "average_load": 0,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 21,
            "outlet_temperature": 16,
            "phase_id": 9,
            "reading_id": 67
            
        },
        {
            "average_load": 0,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
           
            "inlet_temperature": 0,
            "outlet_temperature": 0,
            "phase_id": 9,
            "reading_id": 68
           
        },
        {
            "average_load": 502,
            "branch_id": 39,
            "chiller_id": 48,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,
            
            "inlet_temperature": 24,
            "outlet_temperature": 22,
            "phase_id": 12,
            "reading_id": 69
            
        },
        {
            "average_load": 200,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,            
            "inlet_temperature": 20,
            "outlet_temperature": 19,
            "phase_id": 9,
            "reading_id": 70
            
        },
        {
            "average_load": 110,
            "branch_id": 1,
            "chiller_id": 14,
            "circulation_pump_1_status": null,
            "circulation_pump_2_status": null,            
            "inlet_temperature": 120,
            "outlet_temperature": 120,
            "phase_id": 9,
            "reading_id": 71
            
        }
    ]
}
    ''';
    var parentData = <Parent>[].obs;
    var childData = <Child>[].obs;
    final jsonMap = json.decode(jsonData);
    final parentChildData = ParentChildData.fromJson(jsonMap);

    parentData.value = parentChildData.parents ?? [];
    childData.value = parentChildData.children ?? [];
    var masterData = <String, dynamic>{};

    for (int i = 0; i < parentData.length; i++) {

      for(int j=0 ; j<childData.length ; j++){
        if(parentData[i].readingId == childData[j].crId){
          if(masterData.containsKey(parentData[i].readingId.toString())){

          }
           masterData[parentData[i].readingId.toString()] = [
             {
              "average_load": parentData[i].averageLoad,
              "branch_id": parentData[i].branchId,
              "chiller_id": parentData[i].chillerId,
              "circulation_pump_1_status": parentData[i].circulationPump1Status,
              "circulation_pump_2_status": parentData[i].circulationPump2Status,
              "inlet_temperature": parentData[i].inletTemperature,
              "outlet_temperature": parentData[i].outletTemperature,
              "phase_id": parentData[i].phaseId,
              "ccr_id": childData[j].ccrId,
              "compressor_id": childData[j].compressorId,
              "status": childData[j].status
              },
          ];

        }
      }
    }
    print(masterData);
  }

  Future<void> fetchChillerReading({required var selectedDate}) async {
    isLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_reading?created_on=$selectedDate'), headers: {
      'Authorization': 'Bearer $token',
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChillerReading.fromJson(json);
      chillerReadingDataList.value = data.data ?? [];
      isLoading.value = false;
    } else {
      isLoading.value = false;
      chillerReadingDataList.value = [];
      log(response.body.toString());
    }
  }

  Future<void> fetchChillerCompressorReading({required var chillerReadingId}) async {
    isCompressorLoading.value = true;
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    final response = await http.get(Uri.parse('$apiUrl/get_chiller_compressor_reading?cr_id=$chillerReadingId'), headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      var data = ModelChillerCompressorReading.fromJson(json);
      chillerCompressorDataList.value = data.data ?? [];

      isCompressorLoading.value = false;
    } else {
      isCompressorLoading.value = false;
      chillerCompressorDataList.value = [];
      log(response.body.toString());
    }
  }
}
