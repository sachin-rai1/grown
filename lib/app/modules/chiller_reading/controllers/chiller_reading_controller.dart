import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChillerReadingController extends GetxController {
  final inletTemperature = TextEditingController();
  final outletTemperature = TextEditingController();
  final averageLoad = TextEditingController();
  final compressorStatus = TextEditingController();
  final negativeVoltage = TextEditingController();
  var status = "false".obs;

  List branch = [
    {
      "branch_id": 1,
      "branch_name": "Maitri",
      "floor": "2",
      "no_of_machines": 320
    },
    {
      "branch_id": 2,
      "branch_name": "DM",
      "floor": "1",
      "no_of_machines": 150
    },
    {
      "branch_id": 20,
      "branch_name": "Mumbai",
      "floor": "2",
      "no_of_machines": 120
    }
  ];
  var selectedBranch = "".obs;

  List phase = [{"phaseID":"1" , "phaseName":"phase 1"},{"phaseID":"2" , "phaseName":"phase 2"},{"phaseID":"3" , "phaseName":"phase 3"},{"phaseID":"4" , "phaseName":"phase 4"}, ];
  var selectedPhase = "".obs;

  List chiller = [{"chillerId":"1" , "chillerName":"Chiller 1"},{"chillerId":"2" , "chillerName":"Chiller 2"},{"chillerId":"3" , "chillerName":"Chiller 3"},{"chillerId":"4" , "chillerName":"Chiller 4"}, ];
  var selectedChiller = "".obs;




}
