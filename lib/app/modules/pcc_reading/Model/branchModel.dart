
// To parse this JSON data, do
//
//     final branches = branchesFromJson(jsonString);

import 'dart:convert';

List<Branches> branchesFromJson(String str) => List<Branches>.from(json.decode(str).map((x) => Branches.fromJson(x)));

String branchesToJson(List<Branches> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Branches {
  int? branchId;
  String? branchName;
  String? floor;
  int? noOfMachines;

  Branches({
    this.branchId,
    this.branchName,
    this.floor,
    this.noOfMachines,
  });

  factory Branches.fromJson(Map<String, dynamic> json) => Branches(
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


