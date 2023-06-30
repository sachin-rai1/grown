import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? message;
  String? privilage;
  String? token;
  int? userBranchId;
  String? userBranchName;
  int? userDepartmentId;
  String? userDepartmentName;
  String? userEmail;
  int? userId;

  UserModel({
    this.message,
    this.privilage,
    this.token,
    this.userBranchId,
    this.userBranchName,
    this.userDepartmentId,
    this.userDepartmentName,
    this.userEmail,
    this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    message: json["message"],
    privilage: json["privilage"],
    token: json["token"],
    userBranchId: json["user_branch_id"],
    userBranchName: json["user_branch_name"],
    userDepartmentId: json["user_department_id"],
    userDepartmentName: json["user_department_name"],
    userEmail: json["user_email"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "privilage": privilage,
    "token": token,
    "user_branch_id": userBranchId,
    "user_branch_name": userBranchName,
    "user_department_id": userDepartmentId,
    "user_department_name": userDepartmentName,
    "user_email": userEmail,
    "user_id": userId,
  };
}
