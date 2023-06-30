// To parse this JSON data, do
//
//     final modelPreRunData = modelPreRunDataFromJson(jsonString);

import 'dart:convert';

ModelPreRunData modelPreRunDataFromJson(String str) => ModelPreRunData.fromJson(json.decode(str));

String modelPreRunDataToJson(ModelPreRunData data) => json.encode(data.toJson());

class ModelPreRunData {
  List<PreRunData>? data;

  ModelPreRunData({
    this.data,
  });

  factory ModelPreRunData.fromJson(Map<String, dynamic> json) => ModelPreRunData(
    data: json["data"] == null ? [] : List<PreRunData>.from(json["data"]!.map((x) => PreRunData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PreRunData {
  String? createdOn;
  String? image;
  int? imageSide;
  int? imageType;
  int? preRunNoId;
  int? runNoFk;
  String? updatedOn;

  PreRunData({
    this.createdOn,
    this.image,
    this.imageSide,
    this.imageType,
    this.preRunNoId,
    this.runNoFk,
    this.updatedOn,
  });

  factory PreRunData.fromJson(Map<String, dynamic> json) => PreRunData(
    createdOn: json["created_on"],
    image: json["image"],
    imageSide: json["image_side"],
    imageType: json["image_type"],
    preRunNoId: json["pre_run_no_id"],
    runNoFk: json["run_no_fk"],
    updatedOn: json["updated_on"],
  );

  Map<String, dynamic> toJson() => {
    "created_on": createdOn,
    "image": image,
    "image_side": imageSide,
    "image_type": imageType,
    "pre_run_no_id": preRunNoId,
    "run_no_fk": runNoFk,
    "updated_on": updatedOn,
  };
}
