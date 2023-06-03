// To parse this JSON data, do
//
//     final modelUpsReading = modelUpsReadingFromJson(jsonString);

import 'dart:convert';

ModelUpsReading modelUpsReadingFromJson(String str) => ModelUpsReading.fromJson(json.decode(str));

String modelUpsReadingToJson(ModelUpsReading data) => json.encode(data.toJson());

class ModelUpsReading {
  ModelUpsReading({
    this.data,
  });

  List<UpsReadingData>? data;

  factory ModelUpsReading.fromJson(Map<String, dynamic> json) => ModelUpsReading(
    data: json["data"] == null ? [] : List<UpsReadingData>.from(json["data"]!.map((x) => UpsReadingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UpsReadingData {
  UpsReadingData({
    this.branchId,
    this.branchName,
    this.createdOn,
    this.dcNegativeVoltage,
    this.dcPositiveVoltage,
    this.ledStatus,
    this.loadsOnUpsB,
    this.loadsOnUpsR,
    this.loadsOnUpsY,
    this.readingId,
    this.upsId,
    this.upsName,
  });

  int? branchId;
  String? branchName;
  DateTime? createdOn;
  int? dcNegativeVoltage;
  int? dcPositiveVoltage;
  int? ledStatus;
  int? loadsOnUpsB;
  int? loadsOnUpsR;
  int? loadsOnUpsY;
  int? readingId;
  int? upsId;
  String? upsName;

  factory UpsReadingData.fromJson(Map<String, dynamic> json) => UpsReadingData(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    dcNegativeVoltage: json["dc_negative_voltage"],
    dcPositiveVoltage: json["dc_positive_voltage"],
    ledStatus: json["led_status"],
    loadsOnUpsB: json["loads_on_ups_b"],
    loadsOnUpsR: json["loads_on_ups_r"],
    loadsOnUpsY: json["loads_on_ups_y"],
    readingId: json["reading_id"],
    upsId: json["ups_id"],
    upsName: json["ups_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "created_on": createdOn?.toIso8601String(),
    "dc_negative_voltage": dcNegativeVoltage,
    "dc_positive_voltage": dcPositiveVoltage,
    "led_status": ledStatus,
    "loads_on_ups_b": loadsOnUpsB,
    "loads_on_ups_r": loadsOnUpsR,
    "loads_on_ups_y": loadsOnUpsY,
    "reading_id": readingId,
    "ups_id": upsId,
    "ups_name": upsName,
  };
}
