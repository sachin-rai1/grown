


// To parse this JSON data, do
//
//     final modelPccList = modelPccListFromJson(jsonString);

import 'dart:convert';

ModelPccList modelPccListFromJson(String str) => ModelPccList.fromJson(json.decode(str));

String modelPccListToJson(ModelPccList data) => json.encode(data.toJson());

class ModelPccList {
  List<Pccmodel>? data;

  ModelPccList({
    this.data,
  });

  factory ModelPccList.fromJson(Map<String, dynamic> json) => ModelPccList(
    data: json["data"] == null ? [] : List<Pccmodel>.from(json["data"]!.map((x) => Pccmodel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Pccmodel {
  dynamic branchCreatedOn;
  int? branchId;
  int? branchIdFk;
  String? branchName;
  dynamic branchUpdatedOn;
  String? createdOn;
  int? pccId;
  String? pccName;
  dynamic updatedOn;
  int? userBranchIdFk;
  dynamic userCreatedOn;
  String? userEmail;
  int? userId;
  int? userIdFk;
  String? userName;
  String? userUpdatedOn;

  Pccmodel({
    this.branchCreatedOn,
    this.branchId,
    this.branchIdFk,
    this.branchName,
    this.branchUpdatedOn,
    this.createdOn,
    this.pccId,
    this.pccName,
    this.updatedOn,
    this.userBranchIdFk,
    this.userCreatedOn,
    this.userEmail,
    this.userId,
    this.userIdFk,
    this.userName,
    this.userUpdatedOn,
  });

  factory Pccmodel.fromJson(Map<String, dynamic> json) => Pccmodel(
    branchCreatedOn: json["branch_created_on"],
    branchId: json["branch_id"],
    branchIdFk: json["branch_id_fk"],
    branchName: json["branch_name"],
    branchUpdatedOn: json["branch_updated_on"],
    createdOn: json["created_on"],
    pccId: json["pcc_id"],
    pccName: json["pcc_name"],
    updatedOn: json["updated_on"],
    userBranchIdFk: json["user_branch_id_fk"],
    userCreatedOn: json["user_created_on"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    userIdFk: json["user_id_fk"],
    userName: json["user_name"],
    userUpdatedOn: json["user_updated_on"],
  );

  Map<String, dynamic> toJson() => {
    "branch_created_on": branchCreatedOn,
    "branch_id": branchId,
    "branch_id_fk": branchIdFk,
    "branch_name": branchName,
    "branch_updated_on": branchUpdatedOn,
    "created_on": createdOn,
    "pcc_id": pccId,
    "pcc_name": pccName,
    "updated_on": updatedOn,
    "user_branch_id_fk": userBranchIdFk,
    "user_created_on": userCreatedOn,
    "user_email": userEmail,
    "user_id": userId,
    "user_id_fk": userIdFk,
    "user_name": userName,
    "user_updated_on": userUpdatedOn,
  };
}



