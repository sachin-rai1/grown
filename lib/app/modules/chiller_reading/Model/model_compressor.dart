// To parse this JSON data, do
//
//     final modelCompressor = modelCompressorFromJson(jsonString);

import 'dart:convert';

ModelCompressor modelCompressorFromJson(String str) => ModelCompressor.fromJson(json.decode(str));

String modelCompressorToJson(ModelCompressor data) => json.encode(data.toJson());

class ModelCompressor {
  List<CompressorData>? compressor;

  ModelCompressor({
    this.compressor,
  });

  factory ModelCompressor.fromJson(Map<String, dynamic> json) => ModelCompressor(
    compressor: json["Compressor"] == null ? [] : List<CompressorData>.from(json["Compressor"]!.map((x) => CompressorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Compressor": compressor == null ? [] : List<dynamic>.from(compressor!.map((x) => x.toJson())),
  };
}

class CompressorData {
  int? chillerId;
  String? chillerName;
  int? compressorId;
  String? compressorName;

  CompressorData({
    this.chillerId,
    this.chillerName,
    this.compressorId,
    this.compressorName,
  });

  factory CompressorData.fromJson(Map<String, dynamic> json) => CompressorData(
    chillerId: json["chiller_id"],
    chillerName: json["chiller_name"],
    compressorId: json["compressor_id"],
    compressorName: json["compressor_name"],
  );

  Map<String, dynamic> toJson() => {
    "chiller_id": chillerId,
    "chiller_name": chillerName,
    "compressor_id": compressorId,
    "compressor_name": compressorName,
  };
}
