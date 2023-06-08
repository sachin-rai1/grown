// To parse this JSON data, do
//
//     final modelProblems = modelProblemsFromJson(jsonString);

import 'dart:convert';

ModelProblems modelProblemsFromJson(String str) => ModelProblems.fromJson(json.decode(str));

String modelProblemsToJson(ModelProblems data) => json.encode(data.toJson());

class ModelProblems {
  List<ProblemsData>? data;

  ModelProblems({
    this.data,
  });

  factory ModelProblems.fromJson(Map<String, dynamic> json) => ModelProblems(
    data: json["data"] == null ? [] : List<ProblemsData>.from(json["data"]!.map((x) => ProblemsData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProblemsData {
  String? description;

  ProblemsData({
    this.description,
  });

  factory ProblemsData.fromJson(Map<String, dynamic> json) => ProblemsData(
    description: json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "Description": description,
  };
}
