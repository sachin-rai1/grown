import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UpsReadingController extends GetxController {
  final loadOnUpsR = TextEditingController();
  final loadOnUpsY = TextEditingController();
  final loadOnUpsB = TextEditingController();
  final positiveVoltage = TextEditingController();
  final negativeVoltage = TextEditingController();
  var status = "".obs;

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
      "branch_name": "SML",
      "floor": "2",
      "no_of_machines": 120
    }
  ];
  var selectedBranch = "".obs;

  List ups = [{"upsID":"1" , "upsName":"ups1"},{"upsID":"2" , "upsName":"ups2"},{"upsID":"3" , "upsName":"ups3"},{"upsID":"4" , "upsName":"ups4"}, ];
  var selectedUps = "".obs;

}
