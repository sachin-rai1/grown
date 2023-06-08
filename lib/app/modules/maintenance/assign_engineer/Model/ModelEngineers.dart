// To parse this JSON data, do
//
//     final modelEngineers = modelEngineersFromJson(jsonString);

import 'dart:convert';

ModelEngineers modelEngineersFromJson(String str) => ModelEngineers.fromJson(json.decode(str));

String modelEngineersToJson(ModelEngineers data) => json.encode(data.toJson());

class ModelEngineers {
  List<Engineers>? data;

  ModelEngineers({
    this.data,
  });

  factory ModelEngineers.fromJson(Map<String, dynamic> json) => ModelEngineers(
    data: json["data"] == null ? [] : List<Engineers>.from(json["data"]!.map((x) => Engineers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Engineers {
  String? engineers;
  int? userBranchId;
  int? userDepartmentId;
  String? userEmail;
  int? userId;

  Engineers({
    this.engineers,
    this.userBranchId,
    this.userDepartmentId,
    this.userEmail,
    this.userId,
  });

  factory Engineers.fromJson(Map<String, dynamic> json) => Engineers(
    engineers: json["engineers"],
    userBranchId: json["user_branch_id"],
    userDepartmentId: json["user_department_id"],
    userEmail: json["user_email"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "engineers": engineers,
    "user_branch_id": userBranchId,
    "user_department_id": userDepartmentId,
    "user_email": userEmail,
    "user_id": userId,
  };
}
