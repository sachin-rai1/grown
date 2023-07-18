
// To parse this JSON data, do
//
//     final pccInsert = pccInsertFromJson(jsonString);

import 'dart:convert';

PccInsert pccInsertFromJson(String str) => PccInsert.fromJson(json.decode(str));

String pccInsertToJson(PccInsert data) => json.encode(data.toJson());

class PccInsert {
  String? loadAmpAcb;
  String? loadAmpMfm;
  String? powerFactorMfm;
  String? allMeterStatusPcc;
  String? allLightStatusPcc;
  String? allExhaustFanStatus;
  String? nEVolt;
  String? rYVolt;
  String? yBVolt;
  String? bRVolt;
  String? rNVolt;
  String? yNVolt;
  String? bNVolt;
  String? rEVolt;
  String? yEVolt;
  String? bEVolt;
  String? remarkIfAny;
  String? branchIdFk;
  String? userIdFk;
  String? pccIdFk;

  PccInsert({
    this.loadAmpAcb,
    this.loadAmpMfm,
    this.powerFactorMfm,
    this.allMeterStatusPcc,
    this.allLightStatusPcc,
    this.allExhaustFanStatus,
    this.nEVolt,
    this.rYVolt,
    this.yBVolt,
    this.bRVolt,
    this.rNVolt,
    this.yNVolt,
    this.bNVolt,
    this.rEVolt,
    this.yEVolt,
    this.bEVolt,
    this.remarkIfAny,
    this.branchIdFk,
    this.userIdFk,
    this.pccIdFk,
  });

  factory PccInsert.fromJson(Map<String, dynamic> json) => PccInsert(
    loadAmpAcb: json["load_amp_acb"],
    loadAmpMfm: json["load_amp_mfm"],
    powerFactorMfm: json["power_factor_mfm"],
    allMeterStatusPcc: json["all_meter_status_pcc"],
    allLightStatusPcc: json["all_light_status_pcc"],
    allExhaustFanStatus: json["all_exhaust_fan_status"],
    nEVolt: json["n_e_volt"],
    rYVolt: json["r_y_volt"],
    yBVolt: json["y_b_volt"],
    bRVolt: json["b_r_volt"],
    rNVolt: json["r_n_volt"],
    yNVolt: json["y_n_volt"],
    bNVolt: json["b_n_volt"],
    rEVolt: json["r_e_volt"],
    yEVolt: json["y_e_volt"],
    bEVolt: json["b_e_volt"],
    remarkIfAny: json["remark_If_any"],
    branchIdFk: json["branch_id_fk"],
    userIdFk: json["user_id_fk"],
    pccIdFk: json["pcc_id_fk"],
  );

  Map<String, dynamic> toJson() => {
    "load_amp_acb": loadAmpAcb,
    "load_amp_mfm": loadAmpMfm,
    "power_factor_mfm": powerFactorMfm,
    "all_meter_status_pcc": allMeterStatusPcc,
    "all_light_status_pcc": allLightStatusPcc,
    "all_exhaust_fan_status": allExhaustFanStatus,
    "n_e_volt": nEVolt,
    "r_y_volt": rYVolt,
    "y_b_volt": yBVolt,
    "b_r_volt": bRVolt,
    "r_n_volt": rNVolt,
    "y_n_volt": yNVolt,
    "b_n_volt": bNVolt,
    "r_e_volt": rEVolt,
    "y_e_volt": yEVolt,
    "b_e_volt": bEVolt,
    "remark_If_any": remarkIfAny,
    "branch_id_fk": branchIdFk,
    "user_id_fk": userIdFk,
    "pcc_id_fk": pccIdFk,
  };
}







