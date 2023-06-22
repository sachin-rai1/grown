// To parse this JSON data, do
//
//     final modelChillerReading = modelChillerReadingFromJson(jsonString);

import 'dart:convert';

ModelChillerReading modelChillerReadingFromJson(String str) => ModelChillerReading.fromJson(json.decode(str));

String modelChillerReadingToJson(ModelChillerReading data) => json.encode(data.toJson());

class ModelChillerReading {
  List<ChillerReadingData>? data;

  ModelChillerReading({
    this.data,
  });

  factory ModelChillerReading.fromJson(Map<String, dynamic> json) => ModelChillerReading(
    data: json["data"] == null ? [] : List<ChillerReadingData>.from(json["data"]!.map((x) => ChillerReadingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChillerReadingData {
  double? averageLoad;
  int? branchId;
  String? branchName;
  int? chillerId;
  String? chillerName;
  int? circulationPump1Status;
  int? circulationPump2Status;
  DateTime? createdOn;
  double? inletTemperature;
  double? outletTemperature;
  int? phaseId;
  String? phaseName;
  int? readingId;
  double? processPumpPressure;

  ChillerReadingData({
    this.averageLoad,
    this.branchId,
    this.branchName,
    this.chillerId,
    this.chillerName,
    this.circulationPump1Status,
    this.circulationPump2Status,
    this.createdOn,
    this.inletTemperature,
    this.outletTemperature,
    this.phaseId,
    this.phaseName,
    this.readingId,
    this.processPumpPressure
  });

  factory ChillerReadingData.fromJson(Map<String, dynamic> json) => ChillerReadingData(
    averageLoad: json["average_load"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    chillerId: json["chiller_id"],
    chillerName: json["chiller_name"],
    circulationPump1Status: json["circulation_pump_1_status"],
    circulationPump2Status: json["circulation_pump_2_status"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    inletTemperature: json["inlet_temperature"],
    outletTemperature: json["outlet_temperature"],
    phaseId: json["phase_id"],
    phaseName: json["phase_name"],
    readingId: json["reading_id"],
    processPumpPressure: json["process_pump_pressure"]
  );

  Map<String, dynamic> toJson() => {
    "average_load": averageLoad,
    "branch_id": branchId,
    "branch_name": branchName,
    "chiller_id": chillerId,
    "chiller_name": chillerName,
    "circulation_pump_1_status": circulationPump1Status,
    "circulation_pump_2_status": circulationPump2Status,
    "created_on": createdOn?.toIso8601String(),
    "inlet_temperature": inletTemperature,
    "outlet_temperature": outletTemperature,
    "phase_id": phaseId,
    "phase_name": phaseName,
    "reading_id": readingId,
    "process_pump_pressure":processPumpPressure
  };
}
