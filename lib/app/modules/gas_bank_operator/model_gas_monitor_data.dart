// To parse this JSON data, do
//
//     final modelGasMonitor = modelGasMonitorFromJson(jsonString);

import 'dart:convert';

ModelGasMonitor modelGasMonitorFromJson(String str) => ModelGasMonitor.fromJson(json.decode(str));

String modelGasMonitorToJson(ModelGasMonitor data) => json.encode(data.toJson());

class ModelGasMonitor {
  ModelGasMonitor({
    this.onlineGasMonitors,
    this.standbyGasMonitors,
    this.stockGasMonitors,
  });

  List<GasMonitor>? onlineGasMonitors;
  List<GasMonitor>? standbyGasMonitors;
  List<GasMonitor>? stockGasMonitors;

  factory ModelGasMonitor.fromJson(Map<String, dynamic> json) => ModelGasMonitor(
    onlineGasMonitors: json["online_gas_monitors"] == null ? [] : List<GasMonitor>.from(json["online_gas_monitors"]!.map((x) => GasMonitor.fromJson(x))),
    standbyGasMonitors: json["standby_gas_monitors"] == null ? [] : List<GasMonitor>.from(json["standby_gas_monitors"]!.map((x) => GasMonitor.fromJson(x))),
    stockGasMonitors: json["stock_gas_monitors"] == null ? [] : List<GasMonitor>.from(json["stock_gas_monitors"]!.map((x) => GasMonitor.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "online_gas_monitors": onlineGasMonitors == null ? [] : List<dynamic>.from(onlineGasMonitors!.map((x) => x.toJson())),
    "standby_gas_monitors": standbyGasMonitors == null ? [] : List<dynamic>.from(standbyGasMonitors!.map((x) => x.toJson())),
    "stock_gas_monitors": stockGasMonitors == null ? [] : List<dynamic>.from(stockGasMonitors!.map((x) => x.toJson())),
  };
}

class GasMonitor {
  GasMonitor({
    this.branchId,
    this.branchName,
    this.consumption,
    this.dueDate,
    this.gasQty,
    this.gasMonitorId,
    this.gasName,
    this.gasesId,
    this.manifoldId,
    this.manifoldName,
    this.operatorName,
    this.remainingStock,
    this.remainingStockDays,
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
  String? dueDate;
  int? gasQty;
  int? gasMonitorId;
  String? gasName;
  int? gasesId;
  int? manifoldId;
  String? manifoldName;
  String? operatorName;
  int? remainingStock;
  int? remainingStockDays;
  String? serialNo;
  String? startingOn;
  int? statusId;
  String? statusName;
  int? vendorId;
  String? vendorName;

  factory GasMonitor.fromJson(Map<String, dynamic> json) => GasMonitor(
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    consumption: json["consumption"],
    dueDate: json["due_Date"],
    gasQty: json["gas_Qty"],
    gasMonitorId: json["gas_monitor_id"],
    gasName: json["gas_name"],
    gasesId: json["gases_id"],
    manifoldId: json["manifold_id"],
    manifoldName: json["manifold_name"],
    operatorName: json["operator_name"],
    remainingStock: json["remaining_stock"],
    remainingStockDays: json["remaining_stock_days"],
    serialNo: json["serial_no"],
    startingOn: json["starting_on"],
    statusId: json["status_id"],
    statusName: json["status_name"],
    vendorId: json["vendor_id"],
    vendorName: json["vendor_name"],
  );

  Map<String, dynamic> toJson() => {
    "branch_id": branchId,
    "branch_name": branchName,
    "consumption": consumption,
    "due_Date": dueDate,
    "gas_Qty": gasQty,
    "gas_monitor_id": gasMonitorId,
    "gas_name": gasName,
    "gases_id": gasesId,
    "manifold_id": manifoldId,
    "manifold_name": manifoldName,
    "operator_name": operatorName,
    "remaining_stock": remainingStock,
    "remaining_stock_days": remainingStockDays,
    "serial_no": serialNo,
    "starting_on": startingOn,
    "status_id": statusId,
    "status_name": statusName,
    "vendor_id": vendorId,
    "vendor_name": vendorName,
  };
}
