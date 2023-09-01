// To parse this JSON data, do
//
//     final modelBcdiMultiLabel = modelBcdiMultiLabelFromJson(jsonString);

import 'dart:convert';

ModelBcdiMultiLabel modelBcdiMultiLabelFromJson(String str) => ModelBcdiMultiLabel.fromJson(json.decode(str));

String modelBcdiMultiLabelToJson(ModelBcdiMultiLabel data) => json.encode(data.toJson());

class ModelBcdiMultiLabel {
  Data? data;

  ModelBcdiMultiLabel({
    this.data,
  });

  factory ModelBcdiMultiLabel.fromJson(Map<String, dynamic> json) => ModelBcdiMultiLabel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  int? dataClass;
  Percentage? percentage;
  String? image;
  List<int>? imageSize;
  List<IndexDt>? indexDt;

  Data({
    this.dataClass,
    this.percentage,
    this.image,
    this.imageSize,
    this.indexDt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataClass: json["Class"],
    percentage: json["Percentage"] == null ? null : Percentage.fromJson(json["Percentage"]),
    image: json["image"],
    imageSize: json["image size"] == null ? [] : List<int>.from(json["image size"]!.map((x) => x)),
    indexDt: json["index_dt"] == null ? [] : List<IndexDt>.from(json["index_dt"]!.map((x) => IndexDt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Class": dataClass,
    "Percentage": percentage?.toJson(),
    "image": image,
    "image size": imageSize == null ? [] : List<dynamic>.from(imageSize!.map((x) => x)),
    "index_dt": indexDt == null ? [] : List<dynamic>.from(indexDt!.map((x) => x.toJson())),
  };
}

class IndexDt {
  List<double>? bBox;
  String? indexDtClass;
  int? index;

  IndexDt({
    this.bBox,
    this.indexDtClass,
    this.index,
  });

  factory IndexDt.fromJson(Map<String, dynamic> json) => IndexDt(
    bBox: json["BBox"] == null ? [] : List<double>.from(json["BBox"]!.map((x) => x?.toDouble())),
    indexDtClass: json["class"],
    index: json["index"],
  );

  Map<String, dynamic> toJson() => {
    "BBox": bBox == null ? [] : List<dynamic>.from(bBox!.map((x) => x)),
    "class": indexDtClass,
    "index": index,
  };
}

class Percentage {
  Percentage();

  factory Percentage.fromJson(Map<String, dynamic> json) => Percentage(
  );

  Map<String, dynamic> toJson() => {
  };
}
