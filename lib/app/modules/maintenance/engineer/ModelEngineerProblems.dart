// To parse this JSON data, do
//
//     final modelEngineersProblems = modelEngineersProblemsFromJson(jsonString);

import 'dart:convert';

ModelEngineersProblems modelEngineersProblemsFromJson(String str) => ModelEngineersProblems.fromJson(json.decode(str));

String modelEngineersProblemsToJson(ModelEngineersProblems data) => json.encode(data.toJson());

class ModelEngineersProblems {
  List<EngineersProblem>? data;

  ModelEngineersProblems({
    this.data,
  });

  factory ModelEngineersProblems.fromJson(Map<String, dynamic> json) => ModelEngineersProblems(
    data: json["data"] == null ? [] : List<EngineersProblem>.from(json["data"]!.map((x) => EngineersProblem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class EngineersProblem {
  int? branchIdFk;
  int? complainId;
  int? complainIdFk;
  DateTime? complainTbCreatedOn;
  int? complainerIdFk;
  int? department;
  String? description;
  int? engineerId;
  String? engineerName;
  String? machineName;
  String? machineNo;
  List<String>? otherEngineers;
  List<String>? photos;
  String? privilege;
  String? problemDescription;
  List<String>? problemSolved;
  List<String>? problemsAssigned;
  int? status;
  String? ticketNo;
  int? uniqueId;
  String? userEmail;
  int? userId;
  int? userIdFk;
  String? userName;

  EngineersProblem({
    this.branchIdFk,
    this.complainId,
    this.complainIdFk,
    this.complainTbCreatedOn,
    this.complainerIdFk,
    this.department,
    this.description,
    this.engineerId,
    this.engineerName,
    this.machineName,
    this.machineNo,
    this.otherEngineers,
    this.photos,
    this.privilege,
    this.problemDescription,
    this.problemSolved,
    this.problemsAssigned,
    this.status,
    this.ticketNo,
    this.uniqueId,
    this.userEmail,
    this.userId,
    this.userIdFk,
    this.userName,
  });

  factory EngineersProblem.fromJson(Map<String, dynamic> json) => EngineersProblem(
    branchIdFk: json["branch_id_fk"],
    complainId: json["complain_id"],
    complainIdFk: json["complain_id_fk"],
    complainTbCreatedOn: json["complain_tb_created_on"] == null ? null : DateTime.parse(json["complain_tb_created_on"]),
    complainerIdFk: json["complainer_id_fk"],
    department: json["department"],
    description: json["description"],
    engineerId: json["engineer_id"],
    engineerName: json["engineer_name"],
    machineName: json["machine_name"],
    machineNo: json["machine_no"],
    otherEngineers: json["other_engineers"] == null ? [] : List<String>.from(json["other_engineers"]!.map((x) => x)),
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    privilege: json["privilege"],
    problemDescription: json["problem_description"],
    problemSolved: json["problem_solved"] == null ? [] : List<String>.from(json["problem_solved"]!.map((x) => x)),
    problemsAssigned: json["problems_assigned"] == null ? [] : List<String>.from(json["problems_assigned"]!.map((x) => x)),
    status: json["status"],
    ticketNo: json["ticket_no"],
    uniqueId: json["unique_id"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    userIdFk: json["user_id_fk"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id_fk": branchIdFk,
    "complain_id": complainId,
    "complain_id_fk": complainIdFk,
    "complain_tb_created_on": complainTbCreatedOn?.toIso8601String(),
    "complainer_id_fk": complainerIdFk,
    "department": department,
    "description": description,
    "engineer_id": engineerId,
    "engineer_name": engineerName,
    "machine_name": machineName,
    "machine_no": machineNo,
    "other_engineers": otherEngineers == null ? [] : List<dynamic>.from(otherEngineers!.map((x) => x)),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "privilege": privilege,
    "problem_description": problemDescription,
    "problem_solved": problemSolved == null ? [] : List<dynamic>.from(problemSolved!.map((x) => x)),
    "problems_assigned": problemsAssigned == null ? [] : List<dynamic>.from(problemsAssigned!.map((x) => x)),
    "status": status,
    "ticket_no": ticketNo,
    "unique_id": uniqueId,
    "user_email": userEmail,
    "user_id": userId,
    "user_id_fk": userIdFk,
    "user_name": userName,
  };
}
