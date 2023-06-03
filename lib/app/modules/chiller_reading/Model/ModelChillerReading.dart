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
  int? averageLoad;
  int? branchId;
  String? branchName;
  int? chillerId;
  String? chillerName;
  String? createdOn;
  int? inletTemperature;
  int? outletTemperature;
  int? phaseId;
  String? phaseName;
  int? readingId;

  ChillerReadingData({
    this.averageLoad,
    this.branchId,
    this.branchName,
    this.chillerId,
    this.chillerName,
    this.createdOn,
    this.inletTemperature,
    this.outletTemperature,
    this.phaseId,
    this.phaseName,
    this.readingId,
  });

  factory ChillerReadingData.fromJson(Map<String, dynamic> json) => ChillerReadingData(
    averageLoad: json["average_load"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    chillerId: json["chiller_id"],
    chillerName: json["chiller_name"],
    createdOn: json["created_on"],
    inletTemperature: json["inlet_temperature"],
    outletTemperature: json["outlet_temperature"],
    phaseId: json["phase_id"],
    phaseName: json["phase_name"],
    readingId: json["reading_id"],
  );

  Map<String, dynamic> toJson() => {
    "average_load": averageLoad,
    "branch_id": branchId,
    "branch_name": branchName,
    "chiller_id": chillerId,
    "chiller_name": chillerName,
    "created_on": createdOn,
    "inlet_temperature": inletTemperature,
    "outlet_temperature": outletTemperature,
    "phase_id": phaseId,
    "phase_name": phaseName,
    "reading_id": readingId,
  };
}
