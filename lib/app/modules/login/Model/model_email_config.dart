// To parse this JSON data, do
//
//     final modelEmailConfig = modelEmailConfigFromJson(jsonString);

import 'dart:convert';

ModelEmailConfig modelEmailConfigFromJson(String str) => ModelEmailConfig.fromJson(json.decode(str));

String modelEmailConfigToJson(ModelEmailConfig data) => json.encode(data.toJson());

class ModelEmailConfig {
  List<Datum>? data;

  ModelEmailConfig({
    this.data,
  });

  factory ModelEmailConfig.fromJson(Map<String, dynamic> json) => ModelEmailConfig(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? branchId;
  int? departmentId;
  int? eId;
  String? engineerCreatedOn;
  String? engineerUpdatedOn;
  String? msg;
  String? port;
  String? privilege;
  String? senderEmail;
  String? server;
  dynamic userCreatedOn;
  String? userEmail;
  int? userId;
  int? userIdFk;
  String? userName;
  dynamic userUpdatedOn;

  Datum({
    this.branchId,
    this.departmentId,
    this.eId,
    this.engineerCreatedOn,
    this.engineerUpdatedOn,
    this.msg,
    this.port,
    this.privilege,
    this.senderEmail,
    this.server,
    this.userCreatedOn,
    this.userEmail,
    this.userId,
    this.userIdFk,
    this.userName,
    this.userUpdatedOn,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    branchId: json["branch_id"],
    departmentId: json["department_id"],
    eId: json["e_id"],
    engineerCreatedOn: json["engineer_created_on"],
    engineerUpdatedOn: json["engineer_updated_on"],
    msg: json["msg"],
    port: json["port"],
    privilege: json["privilege"],
    senderEmail: json["sender_email"],
    server: json["server"],
    userCreatedOn: json["user_created_on"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    userIdFk: json["user_id_fk"],
    userName: json["user_name"],
    userUpdatedOn: json["user_updated_on"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "department_id": departmentId,
    "e_id": eId,
    "engineer_created_on": engineerCreatedOn,
    "engineer_updated_on": engineerUpdatedOn,
    "msg": msg,
    "port": port,
    "privilege": privilege,
    "sender_email": senderEmail,
    "server": server,
    "user_created_on": userCreatedOn,
    "user_email": userEmail,
    "user_id": userId,
    "user_id_fk": userIdFk,
    "user_name": userName,
    "user_updated_on": userUpdatedOn,
  };
}
