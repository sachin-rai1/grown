// To parse this JSON data, do
//
//     final modelViewComplain = modelViewComplainFromJson(jsonString);

import 'dart:convert';

ModelViewComplain modelViewComplainFromJson(String str) => ModelViewComplain.fromJson(json.decode(str));

String modelViewComplainToJson(ModelViewComplain data) => json.encode(data.toJson());

class ModelViewComplain {
  List<Complain>? complain;

  ModelViewComplain({
    this.complain,
  });

  factory ModelViewComplain.fromJson(Map<String, dynamic> json) => ModelViewComplain(
    complain: json["complain"] == null ? [] : List<Complain>.from(json["complain"]!.map((x) => Complain.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "complain": complain == null ? [] : List<dynamic>.from(complain!.map((x) => x.toJson())),
  };
}

class Complain {
  int? branchId;
  int? complainId;
  int? complainerIdFk;
  String? createdOn;
  String? date;
  int? departmentId;
  List<String>? engineers;
  String? machineName;
  String? machineNo;
  List<String>? photos;
  String? privilege;
  String? problemDescription;
  List<String>? problems;
  List<String>? solvedProblems;
  int? status;
  String? ticketNo;
  String? updatedOn;
  int? userBranchId;
  String? userCreatedOnUserTb;
  String? userEmail;
  int? userId;
  String? userName;
  String? userUpdatedOnUserTb;

  Complain({
    this.branchId,
    this.complainId,
    this.complainerIdFk,
    this.createdOn,
    this.date,
    this.departmentId,
    this.engineers,
    this.machineName,
    this.machineNo,
    this.photos,
    this.privilege,
    this.problemDescription,
    this.problems,
    this.solvedProblems,
    this.status,
    this.ticketNo,
    this.updatedOn,
    this.userBranchId,
    this.userCreatedOnUserTb,
    this.userEmail,
    this.userId,
    this.userName,
    this.userUpdatedOnUserTb,
  });

  factory Complain.fromJson(Map<String, dynamic> json) => Complain(
    branchId: json["branch_id"],
    complainId: json["complain_id"],
    complainerIdFk: json["complainer_id_fk"],
    createdOn: json["created_on"],
    date: json["date"],
    departmentId: json["department_id"],
    engineers: json["engineers"] == null ? [] : List<String>.from(json["engineers"]!.map((x) => x)),
    machineName: json["machine_name"],
    machineNo: json["machine_no"],
    photos: json["photos"] == null ? [] : List<String>.from(json["photos"]!.map((x) => x)),
    privilege: json["privilege"],
    problemDescription: json["problem_description"],
    problems: json["problems"] == null ? [] : List<String>.from(json["problems"]!.map((x) => x)),
    solvedProblems: json["solved_problems"] == null ? [] : List<String>.from(json["solved_problems"]!.map((x) => x)),
    status: json["status"],
    ticketNo: json["ticketNo"],
    updatedOn: json["updated_on"],
    userBranchId: json["user_branch_id"],
    userCreatedOnUserTb: json["user_created_on_user_tb"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    userName: json["user_name"],
    userUpdatedOnUserTb: json["user_updated_on_user_tb"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "complain_id": complainId,
    "complainer_id_fk": complainerIdFk,
    "created_on": createdOn,
    "date": date,
    "department_id": departmentId,
    "engineers": engineers == null ? [] : List<dynamic>.from(engineers!.map((x) => x)),
    "machine_name": machineName,
    "machine_no": machineNo,
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
    "privilege": privilege,
    "problem_description": problemDescription,
    "problems": problems == null ? [] : List<dynamic>.from(problems!.map((x) => x)),
    "solved_problems": solvedProblems == null ? [] : List<dynamic>.from(solvedProblems!.map((x) => x)),
    "status": status,
    "ticketNo": ticketNo,
    "updated_on": updatedOn,
    "user_branch_id": userBranchId,
    "user_created_on_user_tb": userCreatedOnUserTb,
    "user_email": userEmail,
    "user_id": userId,
    "user_name": userName,
    "user_updated_on_user_tb": userUpdatedOnUserTb,
  };
}
