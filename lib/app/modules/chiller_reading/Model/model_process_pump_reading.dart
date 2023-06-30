import 'dart:convert';

ModelProcessPumpReading modelProcessPumpReadingFromJson(String str) => ModelProcessPumpReading.fromJson(json.decode(str));

String modelProcessPumpReadingToJson(ModelProcessPumpReading data) => json.encode(data.toJson());

class ModelProcessPumpReading {
  List<ProcessPumpReading>? data;

  ModelProcessPumpReading({
    this.data,
  });

  factory ModelProcessPumpReading.fromJson(Map<String, dynamic> json) => ModelProcessPumpReading(
    data: json["data"] == null ? [] : List<ProcessPumpReading>.from(json["data"]!.map((x) => ProcessPumpReading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ProcessPumpReading {
  int? cpprId;
  int? crIdFk;
  int? processPumpIdFk;
  String? processPumpName;
  int? status;

  ProcessPumpReading({
    this.cpprId,
    this.crIdFk,
    this.processPumpIdFk,
    this.processPumpName,
    this.status,
  });

  factory ProcessPumpReading.fromJson(Map<String, dynamic> json) => ProcessPumpReading(
    cpprId: json["cppr_id"],
    crIdFk: json["cr_id_fk"],
    processPumpIdFk: json["process_pump_id_fk"],
    processPumpName: json["process_pump_name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cppr_id": cpprId,
    "cr_id_fk": crIdFk,
    "process_pump_id_fk": processPumpIdFk,
    "process_pump_name": processPumpName,
    "status": status,
  };
}
