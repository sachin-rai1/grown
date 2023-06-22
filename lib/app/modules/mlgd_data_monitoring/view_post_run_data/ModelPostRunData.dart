// To parse this JSON data, do
//
//     final modelPostRunDataReading = modelPostRunDataReadingFromJson(jsonString);

import 'dart:convert';

ModelPostRunDataReading modelPostRunDataReadingFromJson(String str) => ModelPostRunDataReading.fromJson(json.decode(str));

String modelPostRunDataReadingToJson(ModelPostRunDataReading data) => json.encode(data.toJson());

class ModelPostRunDataReading {
  List<ModelPostRunData>? data;

  ModelPostRunDataReading({
    this.data,
  });

  factory ModelPostRunDataReading.fromJson(Map<String, dynamic> json) => ModelPostRunDataReading(
    data: json["data"] == null ? [] : List<ModelPostRunData>.from(json["data"]!.map((x) => ModelPostRunData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ModelPostRunData {
  double? averageGrowthHeight;
  int? bigPcsNo;
  int? breakagePcs;
  int? clarityOnGrowth;
  int? cleanPcsNo;
  int? cleanPercentage;
  DateTime? createdOn;
  int? dotPcs;
  int? finalHeight;
  int? finalWeight;
  String? holderSize;
  int? inclusionPcs;
  int? initialHeight;
  int? initialWeight;
  String? mlgdCreatedOn;
  int? mlgdId;
  String? mlgdUpdatedOn;
  int? newGrowthHeight;
  int? newGrowthWeight;
  String? objective;
  String? operatorName;
  int? postRunNo;
  double? productionPerHour;
  int? regularPcsNo;
  String? remarks;
  int? runNo;
  int? runNoFk;
  int? runId;
  DateTime? runNoCreated;
  int? runningHours;
  String? shutDownReason;
  int? t;
  int? totalPcsArea;
  int? totalPcsNo;
  DateTime? updatedOn;
  int? userIdFk;
  String? userEmail;
  String? userName;
  int? x;
  int? y;
  int? z;

  ModelPostRunData({
    this.averageGrowthHeight,
    this.bigPcsNo,
    this.breakagePcs,
    this.clarityOnGrowth,
    this.cleanPcsNo,
    this.cleanPercentage,
    this.createdOn,
    this.dotPcs,
    this.finalHeight,
    this.finalWeight,
    this.holderSize,
    this.inclusionPcs,
    this.initialHeight,
    this.initialWeight,
    this.mlgdCreatedOn,
    this.mlgdId,
    this.mlgdUpdatedOn,
    this.newGrowthHeight,
    this.newGrowthWeight,
    this.objective,
    this.operatorName,
    this.postRunNo,
    this.productionPerHour,
    this.regularPcsNo,
    this.remarks,
    this.runNo,
    this.runNoFk,
    this.runId,
    this.runNoCreated,
    this.runningHours,
    this.shutDownReason,
    this.t,
    this.totalPcsArea,
    this.totalPcsNo,
    this.updatedOn,
    this.userIdFk,
    this.userEmail,
    this.userName,
    this.x,
    this.y,
    this.z,
  });

  factory ModelPostRunData.fromJson(Map<String, dynamic> json) => ModelPostRunData(
    averageGrowthHeight: json["average_growth_height"]?.toDouble(),
    bigPcsNo: json["bigPcsNo"],
    breakagePcs: json["breakagePcs"],
    clarityOnGrowth: json["clarity_on_growth"],
    cleanPcsNo: json["cleanPcsNo"],
    cleanPercentage: json["clean_percentage"],
    createdOn: json["created_on"] == null ? null : DateTime.parse(json["created_on"]),
    dotPcs: json["dotPcs"],
    finalHeight: json["finalHeight"],
    finalWeight: json["finalWeight"],
    holderSize: json["holderSize"],
    inclusionPcs: json["inclusionPcs"],
    initialHeight: json["initial_height"],
    initialWeight: json["initial_weight"],
    mlgdCreatedOn: json["mlgd_created_on"],
    mlgdId: json["mlgd_id"],
    mlgdUpdatedOn: json["mlgd_updated_on"],
    newGrowthHeight: json["new_growth_height"],
    newGrowthWeight: json["new_growth_weight"],
    objective: json["objective"],
    operatorName: json["operatorName"],
    postRunNo: json["postRunNO"],
    productionPerHour: json["production_per_hour"]?.toDouble(),
    regularPcsNo: json["regularPcsNo"],
    remarks:json["remarks"],
    runNo: json["runNo"],
    runNoFk: json["runNoFk"],
    runId: json["run_id"],
    runNoCreated: json["run_no_created"] == null ? null : DateTime.parse(json["run_no_created"]),
    runningHours: json["runningHours"],
    shutDownReason: json["shutDownReason"],
    t: json["t"],
    totalPcsArea: json["totalPcsArea"],
    totalPcsNo: json["totalPcsNo"],
    updatedOn: json["updated_on"] == null ? null : DateTime.parse(json["updated_on"]),
    userIdFk: json["userIdFk"],
    userEmail: json["user_email"],
    userName: json["user_name"],
    x: json["x"],
    y: json["y"],
    z: json["z"],
  );

  Map<String, dynamic> toJson() => {
    "average_growth_height": averageGrowthHeight,
    "bigPcsNo": bigPcsNo,
    "breakagePcs": breakagePcs,
    "clarity_on_growth": clarityOnGrowth,
    "cleanPcsNo": cleanPcsNo,
    "clean_percentage": cleanPercentage,
    "created_on": createdOn?.toIso8601String(),
    "dotPcs": dotPcs,
    "finalHeight": finalHeight,
    "finalWeight": finalWeight,
    "holderSize": holderSize,
    "inclusionPcs": inclusionPcs,
    "initial_height": initialHeight,
    "initial_weight": initialWeight,
    "mlgd_created_on": mlgdCreatedOn,
    "mlgd_id": mlgdId,
    "mlgd_updated_on": mlgdUpdatedOn,
    "new_growth_height": newGrowthHeight,
    "new_growth_weight": newGrowthWeight,
    "objective": objective,
    "operatorName": operatorName,
    "postRunNO": postRunNo,
    "production_per_hour": productionPerHour,
    "regularPcsNo": regularPcsNo,
    "remarks":remarks,
    "runNo": runNo,
    "runNoFk": runNoFk,
    "run_id": runId,
    "run_no_created": runNoCreated?.toIso8601String(),
    "runningHours": runningHours,
    "shutDownReason": shutDownReason,
    "t": t,
    "totalPcsArea": totalPcsArea,
    "totalPcsNo": totalPcsNo,
    "updated_on": updatedOn?.toIso8601String(),
    "userIdFk": userIdFk,
    "user_email": userEmail,
    "user_name": userName,
    "x": x,
    "y": y,
    "z": z,
  };
}
