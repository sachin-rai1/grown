// To parse this JSON data, do
//
//     final modelMlgdData = modelMlgdDataFromJson(jsonString);

import 'dart:convert';

ModelMlgdData modelMlgdDataFromJson(String str) => ModelMlgdData.fromJson(json.decode(str));

String modelMlgdDataToJson(ModelMlgdData data) => json.encode(data.toJson());

class ModelMlgdData {
  List<MlgdData>? data;

  ModelMlgdData({
    this.data,
  });

  factory ModelMlgdData.fromJson(Map<String, dynamic> json) => ModelMlgdData(
    data: json["data"] == null ? [] : List<MlgdData>.from(json["data"]!.map((x) => MlgdData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MlgdData {
  int? bigPcsNo;
  int? breakagePcs;
  int? cleanPcsNo;
  DateTime? createdOn;
  int? dotPcs;
  String? frontView;
  String? holderSize;
  int? inclusionPcs;
  int? mlgdId;
  String? operatorName;
  int? regularPcsNo;
  int? runNo;
  int? runId;
  int? runningHours;
  int? t;
  String? topView;
  int? totalPcsArea;
  int? totalPcsNo;
  int? x;
  int? y;
  int? z;

  MlgdData({
    this.bigPcsNo,
    this.breakagePcs,
    this.cleanPcsNo,
    this.createdOn,
    this.dotPcs,
    this.frontView,
    this.holderSize,
    this.inclusionPcs,
    this.mlgdId,
    this.operatorName,
    this.regularPcsNo,
    this.runNo,
    this.runId,
    this.runningHours,
    this.t,
    this.topView,
    this.totalPcsArea,
    this.totalPcsNo,
    this.x,
    this.y,
    this.z,
  });

  factory MlgdData.fromJson(Map<String, dynamic> json) => MlgdData(
    bigPcsNo: json["bigPcsNo"],
    breakagePcs: json["breakagePcs"],
    cleanPcsNo: json["cleanPcsNo"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    dotPcs: json["dotPcs"],
    frontView: json["frontView"],
    holderSize: json["holderSize"],
    inclusionPcs: json["inclusionPcs"],
    mlgdId: json["mlgd_id"],
    operatorName: json["operatorName"],
    regularPcsNo: json["regularPcsNo"],
    runNo: json["runNo"],
    runId: json["run_id"],
    runningHours: json["runningHours"],
    t: json["t"],
    topView: json["topView"],
    totalPcsArea: json["totalPcsArea"],
    totalPcsNo: json["totalPcsNo"],
    x: json["x"],
    y: json["y"],
    z: json["z"],
  );

  Map<String, dynamic> toJson() => {
    "bigPcsNo": bigPcsNo,
    "breakagePcs": breakagePcs,
    "cleanPcsNo": cleanPcsNo,
    "created_on": createdOn?.toIso8601String(),
    "dotPcs": dotPcs,
    "frontView": frontView,
    "holderSize": holderSize,
    "inclusionPcs": inclusionPcs,
    "mlgd_id": mlgdId,
    "operatorName": operatorName,
    "regularPcsNo": regularPcsNo,
    "runNo": runNo,
    "run_id": runId,
    "runningHours": runningHours,
    "t": t,
    "topView": topView,
    "totalPcsArea": totalPcsArea,
    "totalPcsNo": totalPcsNo,
    "x": x,
    "y": y,
    "z": z,
  };
}
