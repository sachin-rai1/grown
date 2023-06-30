// To parse this JSON data, do
//
//     final modelphase = modelphaseFromJson(jsonString);

import 'dart:convert';

Modelphase modelphaseFromJson(String str) => Modelphase.fromJson(json.decode(str));

String modelphaseToJson(Modelphase data) => json.encode(data.toJson());

class Modelphase {
  List<PhaseData>? data;

  Modelphase({
    this.data,
  });

  factory Modelphase.fromJson(Map<String, dynamic> json) => Modelphase(
    data: json["data"] == null ? [] : List<PhaseData>.from(json["data"]!.map((x) => PhaseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PhaseData {
  int? branchId;
  String? branchName;
  int? phaseId;
  String? phaseName;

  PhaseData({
    this.branchId,
    this.branchName,
    this.phaseId,
    this.phaseName,
  });

  factory PhaseData.fromJson(Map<String, dynamic> json) => PhaseData(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    phaseId: json["phase_id"],
    phaseName: json["phase_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "phase_id": phaseId,
    "phase_name": phaseName,
  };
}
