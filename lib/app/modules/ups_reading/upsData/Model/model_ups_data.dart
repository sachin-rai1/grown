// To parse this JSON data, do
//
//     final modelUpsData = modelUpsDataFromJson(jsonString);

import 'dart:convert';

ModelUpsData modelUpsDataFromJson(String str) => ModelUpsData.fromJson(json.decode(str));

String modelUpsDataToJson(ModelUpsData data) => json.encode(data.toJson());

class ModelUpsData {
  ModelUpsData({
    this.data,
  });

  List<UpsData>? data;

  factory ModelUpsData.fromJson(Map<String, dynamic> json) => ModelUpsData(
    data: json["data"] == null ? [] : List<UpsData>.from(json["data"]!.map((x) => UpsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class UpsData {
  UpsData({
    this.upsId,
    this.upsName,
  });

  int? upsId;
  String? upsName;

  factory UpsData.fromJson(Map<String, dynamic> json) => UpsData(
    upsId: json["ups_id"],
    upsName: json["ups_name"],
  );

  Map<String, dynamic> toJson() => {
    "ups_id": upsId,
    "ups_name": upsName,
  };
}
