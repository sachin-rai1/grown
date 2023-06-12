// To parse this JSON data, do
//
//     final modelFcmToken = modelFcmTokenFromJson(jsonString);

import 'dart:convert';

ModelFcmToken modelFcmTokenFromJson(String str) => ModelFcmToken.fromJson(json.decode(str));

String modelFcmTokenToJson(ModelFcmToken data) => json.encode(data.toJson());

class ModelFcmToken {
  List<FcmTokenData>? data;

  ModelFcmToken({
    this.data,
  });

  factory ModelFcmToken.fromJson(Map<String, dynamic> json) => ModelFcmToken(
    data: json["data"] == null ? [] : List<FcmTokenData>.from(json["data"]!.map((x) => FcmTokenData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FcmTokenData {
  String? fcmToken;

  FcmTokenData({
    this.fcmToken,
  });

  factory FcmTokenData.fromJson(Map<String, dynamic> json) => FcmTokenData(
    fcmToken: json["fcm_token"],
  );

  Map<String, dynamic> toJson() => {
    "fcm_token": fcmToken,
  };
}
