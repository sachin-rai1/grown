// To parse this JSON data, do
//
//     final modelBcdiDetection = modelBcdiDetectionFromJson(jsonString);

import 'dart:convert';

ModelBcdiDetection modelBcdiDetectionFromJson(String str) => ModelBcdiDetection.fromJson(json.decode(str));

String modelBcdiDetectionToJson(ModelBcdiDetection data) => json.encode(data.toJson());

class ModelBcdiDetection {
  ModelBcdiDetection({
    this.modelBcdiDetectionClass,
    this.percentage,
    this.image,
  });

  List<num>? modelBcdiDetectionClass;
  List<num>? percentage;
  String? image;

  factory ModelBcdiDetection.fromJson(Map<String, dynamic> json) => ModelBcdiDetection(
    modelBcdiDetectionClass: json["Class"] == null ? [] : List<num>.from(json["Class"]!.map((x) => x)),
    percentage: json["Percentage"] == null ? [] : List<num>.from(json["Percentage"]!.map((x) => x)),
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "Class": modelBcdiDetectionClass == null ? [] : List<dynamic>.from(modelBcdiDetectionClass!.map((x) => x)),
    "Percentage": percentage == null ? [] : List<dynamic>.from(percentage!.map((x) => x)),
    "image": image,
  };
}
