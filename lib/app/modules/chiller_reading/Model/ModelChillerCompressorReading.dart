// To parse this JSON data, do
//
//     final modelChillerCompressorReading = modelChillerCompressorReadingFromJson(jsonString);

import 'dart:convert';

ModelChillerCompressorReading modelChillerCompressorReadingFromJson(String str) => ModelChillerCompressorReading.fromJson(json.decode(str));

String modelChillerCompressorReadingToJson(ModelChillerCompressorReading data) => json.encode(data.toJson());

class ModelChillerCompressorReading {
  List<ChillerCompressorData>? data;

  ModelChillerCompressorReading({
    this.data,
  });

  factory ModelChillerCompressorReading.fromJson(Map<String, dynamic> json) => ModelChillerCompressorReading(
    data: json["Data"] == null ? [] : List<ChillerCompressorData>.from(json["Data"]!.map((x) => ChillerCompressorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChillerCompressorData {
  int? ccrId;
  int? compressorId;
  String? compressorName;
  int? crId;
  int? status;

  ChillerCompressorData({
    this.ccrId,
    this.compressorId,
    this.compressorName,
    this.crId,
    this.status,
  });

  factory ChillerCompressorData.fromJson(Map<String, dynamic> json) => ChillerCompressorData(
    ccrId: json["ccr_id"],
    compressorId: json["compressor_id"],
    compressorName: json["compressor_name"],
    crId: json["cr_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "ccr_id": ccrId,
    "compressor_id": compressorId,
    "compressor_name": compressorName,
    "cr_id": crId,
    "status": status,
  };
}
