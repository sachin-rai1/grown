// To parse this JSON data, do
//
//     final modelProcessPump = modelProcessPumpFromJson(jsonString);

import 'dart:convert';

ModelProcessPump modelProcessPumpFromJson(String str) => ModelProcessPump.fromJson(json.decode(str));

String modelProcessPumpToJson(ModelProcessPump data) => json.encode(data.toJson());

class ModelProcessPump {
  List<ProcessPumpData>? data;

  ModelProcessPump({
    this.data,
  });

  factory ModelProcessPump.fromJson(Map<String, dynamic> json) => ModelProcessPump(
    data: json["data"] == null ? [] : List<ProcessPumpData>.from(json["data"]!.map((x) => ProcessPumpData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProcessPumpData {
  int? cppId;
  int? phaseId;
  String? phaseName;
  String? processPumpName;

  ProcessPumpData({
    this.cppId,
    this.phaseId,
    this.phaseName,
    this.processPumpName,
  });

  factory ProcessPumpData.fromJson(Map<String, dynamic> json) => ProcessPumpData(
    cppId: json["cpp_id"],
    phaseId: json["phase_id"],
    phaseName: json["phase_name"],
    processPumpName: json["process_pump_name"],
  );

  Map<String, dynamic> toJson() => {
    "cpp_id": cppId,
    "phase_id": phaseId,
    "phase_name": phaseName,
    "process_pump_name": processPumpName,
  };
}
