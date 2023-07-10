// To parse this JSON data, do
//
//     final modelChillerAndCompressor = modelChillerAndCompressorFromJson(jsonString);

import 'dart:convert';

ModelChillerAndCompressor modelChillerAndCompressorFromJson(String str) => ModelChillerAndCompressor.fromJson(json.decode(str));

String modelChillerAndCompressorToJson(ModelChillerAndCompressor data) => json.encode(data.toJson());

class ModelChillerAndCompressor {
  List<ChillerAndCompressorData>? data;

  ModelChillerAndCompressor({
    this.data,
  });

  factory ModelChillerAndCompressor.fromJson(Map<String, dynamic> json) => ModelChillerAndCompressor(
    data: json["data"] == null ? [] : List<ChillerAndCompressorData>.from(json["data"]!.map((x) => ChillerAndCompressorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChillerAndCompressorData {
  int? chillerId;
  String? chillerName;
  int? compressorId;
  String? compressorName;
  int? phaseId;

  ChillerAndCompressorData({
    this.chillerId,
    this.chillerName,
    this.compressorId,
    this.compressorName,
    this.phaseId,
  });

  factory ChillerAndCompressorData.fromJson(Map<String, dynamic> json) => ChillerAndCompressorData(
    chillerId: json["chiller_id"],
    chillerName: json["chiller_name"],
    compressorId: json["compressor_id"],
    compressorName: json["compressor_name"],
    phaseId: json["phase_id"],
  );

  Map<String, dynamic> toJson() => {
    "chiller_id": chillerId,
    "chiller_name": chillerName,
    "compressor_id": compressorId,
    "compressor_name": compressorName,
    "phase_id": phaseId,
  };
}
