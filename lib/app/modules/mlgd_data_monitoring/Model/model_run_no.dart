// To parse this JSON data, do
//
//     final modelRunNoData = modelRunNoDataFromJson(jsonString);

import 'dart:convert';

ModelRunNoData modelRunNoDataFromJson(String str) => ModelRunNoData.fromJson(json.decode(str));

String modelRunNoDataToJson(ModelRunNoData data) => json.encode(data.toJson());

class ModelRunNoData {
  List<RunNoData>? data;

  ModelRunNoData({
    this.data,
  });

  factory ModelRunNoData.fromJson(Map<String, dynamic> json) => ModelRunNoData(
    data: json["data"] == null ? [] : List<RunNoData>.from(json["data"]!.map((x) => RunNoData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RunNoData {
  int? bigPcsNo;
  DateTime? createdOn;
  String? holderSize;
  int? regularPcsNo;
  int? runNo;
  int? runId;

  int? totalPcsArea;
  int? totalPcsNo;

  RunNoData({
    this.bigPcsNo,
    this.createdOn,
    this.holderSize,
    this.regularPcsNo,
    this.runNo,
    this.runId,

    this.totalPcsArea,
    this.totalPcsNo,
  });

  factory RunNoData.fromJson(Map<String, dynamic> json) => RunNoData(
    bigPcsNo: json["bigPcsNo"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    holderSize: json["holderSize"],
    regularPcsNo: json["regularPcsNo"],
    runNo: json["runNo"],
    runId: json["run_id"],

    totalPcsArea: json["totalPcsArea"],
    totalPcsNo: json["totalPcsNo"],
  );

  Map<String, dynamic> toJson() => {
    "bigPcsNo": bigPcsNo,
    "created_on": createdOn?.toIso8601String(),
    "holderSize": holderSize,
    "regularPcsNo": regularPcsNo,
    "runNo": runNo,
    "run_id": runId,

    "totalPcsArea": totalPcsArea,
    "totalPcsNo": totalPcsNo,
  };
}
