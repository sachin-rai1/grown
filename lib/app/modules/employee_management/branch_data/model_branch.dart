// To parse this JSON data, do
//
//     final modelBranch = modelBranchFromJson(jsonString);

import 'dart:convert';

List<ModelBranch> modelBranchFromJson(String str) => List<ModelBranch>.from(json.decode(str).map((x) => ModelBranch.fromJson(x)));

String modelBranchToJson(List<ModelBranch> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelBranch {
  ModelBranch({
    this.branchId,
    this.branchName,
    this.floor,
    this.noOfMachines,
  });

  int? branchId;
  String? branchName;
  String? floor;
  int? noOfMachines;

  factory ModelBranch.fromJson(Map<String, dynamic> json) => ModelBranch(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    floor: json["floor"],
    noOfMachines: json["no_of_machines"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "floor": floor,
    "no_of_machines": noOfMachines,
  };
}
