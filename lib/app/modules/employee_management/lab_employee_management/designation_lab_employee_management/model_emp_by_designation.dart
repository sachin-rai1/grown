// To parse this JSON data, do
//
//     final employeesByDesignation = employeesByDesignationFromJson(jsonString);

import 'dart:convert';

EmployeesByDesignation employeesByDesignationFromJson(String str) => EmployeesByDesignation.fromJson(json.decode(str));

String employeesByDesignationToJson(EmployeesByDesignation data) => json.encode(data.toJson());

class EmployeesByDesignation {
  EmployeesByDesignation({
    this.employees,
  });

  List<Employee>? employees;

  factory EmployeesByDesignation.fromJson(Map<String, dynamic> json) => EmployeesByDesignation(
    employees: json["employees"] == null ? [] : List<Employee>.from(json["employees"]!.map((x) => Employee.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "employees": employees == null ? [] : List<dynamic>.from(employees!.map((x) => x.toJson())),
  };
}

class Employee {
  Employee({
    this.branchId,
    this.branchName,
    this.designationId,
    this.designationName,
    this.empId,
    this.empName,
    this.ssId,
    this.ssName,
  });

  int? branchId;
  String? branchName;
  int? designationId;
  String? designationName;
  int? empId;
  String? empName;
  int? ssId;
  String? ssName;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    designationId: json["designation_id"],
    designationName: json["designation_name"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    ssId: json["ss_id"],
    ssName: json["ss_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "designation_id": designationId,
    "designation_name": designationName,
    "emp_id": empId,
    "emp_name": empName,
    "ss_id": ssId,
    "ss_name": ssName,
  };
}
