import 'dart:convert';

ModelSerialNoWise modelSerialNoWiseFromJson(String str) => ModelSerialNoWise.fromJson(json.decode(str));

String modelSerialNoWiseToJson(ModelSerialNoWise data) => json.encode(data.toJson());

class ModelSerialNoWise {
  ModelSerialNoWise({
    this.serialWiseData,
  });

  List<SerialWiseData>? serialWiseData;

  factory ModelSerialNoWise.fromJson(Map<String, dynamic> json) => ModelSerialNoWise(
    serialWiseData: json["serial_wise_data"] == null ? [] : List<SerialWiseData>.from(json["serial_wise_data"]!.map((x) => SerialWiseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "serial_wise_data": serialWiseData == null ? [] : List<dynamic>.from(serialWiseData!.map((x) => x.toJson())),
  };
}

class SerialWiseData {
  SerialWiseData({
    this.branchId,
    this.branchName,
    this.consumption,
    this.deletedOn,
    this.dueDate,
    this.gasQty,
    this.gasMonitorId,
    this.gasName,
    this.gasesId,
    this.isDelete,
    this.manifoldId,
    this.manifoldName,
    this.operatorName,
    this.serialNo,
    this.startingOn,
    this.statusId,
    this.statusName,
    this.vendorId,
    this.vendorName,
  });

  int? branchId;
  String? branchName;
  int? consumption;
  String? deletedOn;
  DateTime? dueDate;
  int? gasQty;
  int? gasMonitorId;
  String? gasName;
  int? gasesId;
  int? isDelete;
  int? manifoldId;
  String? manifoldName;
  String? operatorName;
  String? serialNo;
  DateTime? startingOn;
  int? statusId;
  String? statusName;
  int? vendorId;
  String? vendorName;

  factory SerialWiseData.fromJson(Map<String, dynamic> json) => SerialWiseData(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    consumption: json["consumption"],
    deletedOn: json["deleted_on"],
    dueDate: json["due_Date"] == null ? null : DateTime.parse(json["due_Date"]),
    gasQty: json["gas_Qty"],
    gasMonitorId: json["gas_monitor_id"],
    gasName: json["gas_name"],
    gasesId: json["gases_id"],
    isDelete: json["isDelete"],
    manifoldId: json["manifold_id"],
    manifoldName: json["manifold_name"],
    operatorName: json["operator_name"],
    serialNo: json["serial_no"],
    startingOn: json["starting_on"] == null ? null : DateTime.parse(json["starting_on"]),
    statusId: json["status_id"],
    statusName: json["status_name"],
    vendorId: json["vendor_id"],
    vendorName: json["vendor_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "consumption": consumption,
    "deleted_on": deletedOn,
    "due_Date": dueDate?.toIso8601String(),
    "gas_Qty": gasQty,
    "gas_monitor_id": gasMonitorId,
    "gas_name": gasName,
    "gases_id": gasesId,
    "isDelete": isDelete,
    "manifold_id": manifoldId,
    "manifold_name": manifoldName,
    "operator_name": operatorName,
    "serial_no": serialNo,
    "starting_on": startingOn?.toIso8601String(),
    "status_id": statusId,
    "status_name": statusName,
    "vendor_id": vendorId,
    "vendor_name": vendorName,
  };
}
