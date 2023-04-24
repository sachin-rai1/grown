// To parse this JSON data, do
//
//     final employees = employeesFromJson(jsonString);

import 'dart:convert';

Employees employeesFromJson(String str) => Employees.fromJson(json.decode(str));

String employeesToJson(Employees data) => json.encode(data.toJson());

class Employees {
  Employees({
    this.designationCounts,
    this.employees,
    this.requireEmployees,
    this.requiredDesignationPerHundredMachine,
    this.requiredSkillsPerHundredMachine,
    this.skillCounts,
    this.totalEmployee,
    this.totalNoOfMachine,
  });

  List<DesignationCount>? designationCounts;
  List<Employee>? employees;
  int? requireEmployees;
  List<DesignationCount>? requiredDesignationPerHundredMachine;
  List<DesignationCount>? requiredSkillsPerHundredMachine;
  List<DesignationCount>? skillCounts;
  int? totalEmployee;
  TotalNoOfMachine? totalNoOfMachine;

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
    designationCounts: json["designation_counts"] == null ? [] : List<DesignationCount>.from(json["designation_counts"]!.map((x) => DesignationCount.fromJson(x))),
    employees: json["employees"] == null ? [] : List<Employee>.from(json["employees"]!.map((x) => Employee.fromJson(x))),
    requireEmployees: json["requireEmployees"],
    requiredDesignationPerHundredMachine: json["required_designation_per_hundred_machine"] == null ? [] : List<DesignationCount>.from(json["required_designation_per_hundred_machine"]!.map((x) => DesignationCount.fromJson(x))),
    requiredSkillsPerHundredMachine: json["required_skills_per_hundred_machine"] == null ? [] : List<DesignationCount>.from(json["required_skills_per_hundred_machine"]!.map((x) => DesignationCount.fromJson(x))),
    skillCounts: json["skill_counts"] == null ? [] : List<DesignationCount>.from(json["skill_counts"]!.map((x) => DesignationCount.fromJson(x))),
    totalEmployee: json["total_employee"],
    totalNoOfMachine: json["total_no_of_machine"] == null ? null : TotalNoOfMachine.fromJson(json["total_no_of_machine"]),
  );

  Map<String, dynamic> toJson() => {
    "designation_counts": designationCounts == null ? [] : List<dynamic>.from(designationCounts!.map((x) => x.toJson())),
    "employees": employees == null ? [] : List<dynamic>.from(employees!.map((x) => x.toJson())),
    "requireEmployees": requireEmployees,
    "required_designation_per_hundred_machine": requiredDesignationPerHundredMachine == null ? [] : List<dynamic>.from(requiredDesignationPerHundredMachine!.map((x) => x.toJson())),
    "required_skills_per_hundred_machine": requiredSkillsPerHundredMachine == null ? [] : List<dynamic>.from(requiredSkillsPerHundredMachine!.map((x) => x.toJson())),
    "skill_counts": skillCounts == null ? [] : List<dynamic>.from(skillCounts!.map((x) => x.toJson())),
    "total_employee": totalEmployee,
    "total_no_of_machine": totalNoOfMachine?.toJson(),
  };
}

class DesignationCount {
  DesignationCount({
    this.count,
    this.id,
    this.name,
  });

  int? count;
  int? id;
  String? name;

  factory DesignationCount.fromJson(Map<String, dynamic> json) => DesignationCount(
    count: json["count"],
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "id": id,
    "name": name,
  };
}

class Employee {
  Employee({
    this.branchName,
    this.designationName,
    this.empId,
    this.empName,
    this.ssName,
  });

  String? branchName;
  String? designationName;
  int? empId;
  String? empName;
  String? ssName;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    branchName: json["branch_name"],
    designationName: json["designation_name"],
    empId: json["emp_id"],
    empName: json["emp_name"],
    ssName: json["ss_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_name": branchName,
    "designation_name": designationName,
    "emp_id": empId,
    "emp_name": empName,
    "ss_name": ssName,
  };
}

class TotalNoOfMachine {
  TotalNoOfMachine({
    this.noOfMachines,
  });

  int? noOfMachines;

  factory TotalNoOfMachine.fromJson(Map<String, dynamic> json) => TotalNoOfMachine(
    noOfMachines: json["no_of_machines"],
  );

  Map<String, dynamic> toJson() => {
    "no_of_machines": noOfMachines,
  };
}
