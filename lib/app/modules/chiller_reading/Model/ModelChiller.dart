// To parse this JSON data, do
//
//     final modelChiller = modelChillerFromJson(jsonString);

import 'dart:convert';

ModelChiller modelChillerFromJson(String str) => ModelChiller.fromJson(json.decode(str));

String modelChillerToJson(ModelChiller data) => json.encode(data.toJson());

class ModelChiller {
  List<ChillerData>? data;

  ModelChiller({
    this.data,
  });

  factory ModelChiller.fromJson(Map<String, dynamic> json) => ModelChiller(
    data: json["data"] == null ? [] : List<ChillerData>.from(json["data"]!.map((x) => ChillerData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChillerData {
  int? chillerId;
  String? chillerName;
  int? phaseId;
  String? phaseName;

  ChillerData({
    this.chillerId,
    this.chillerName,
    this.phaseId,
    this.phaseName,
  });

  factory ChillerData.fromJson(Map<String, dynamic> json) => ChillerData(
    chillerId: json["chiller_id"],
    chillerName: json["chiller_name"],
    phaseId: json["phase_id"],
    phaseName: json["phase_name"],
  );

  Map<String, dynamic> toJson() => {
    "chiller_id": chillerId,
    "chiller_name": chillerName,
    "phase_id": phaseId,
    "phase_name": phaseName,
  };
}
