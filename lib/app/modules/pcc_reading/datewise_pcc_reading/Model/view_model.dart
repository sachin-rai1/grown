

import 'dart:convert';

ModelPccReport modelPccReportFromJson(String str) => ModelPccReport.fromJson(json.decode(str));

String modelPccReportToJson(ModelPccReport data) => json.encode(data.toJson());

class ModelPccReport {
  List<Report>? report;

  ModelPccReport({
    this.report,
  });

  factory ModelPccReport.fromJson(Map<String, dynamic> json) => ModelPccReport(
    report: json["Report"] == null ? [] : List<Report>.from(json["Report"]!.map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Report": report == null ? [] : List<dynamic>.from(report!.map((x) => x.toJson())),
  };
}

class Report {
  int? allExhaustFanStatus;
  int? allLightStatusPcc;
  int? allMeterStatusPcc;
  String? bEVolt;
  String? bNVolt;
  String? bRVolt;
  String? loadAmpAcb;
  String? loadAmpMfm;
  String? nEVolt;
  String? powerFactorMfm;
  String? rEVolt;
  String? rNVolt;
  String? rYVolt;
  String? remarkIfAny;
  String? yBVolt;
  String? yEVolt;
  String? yNVolt;
  String? branchCreatedOn;
  int? branchId;
  int? branchIdFk;
  String? branchName;
  String? branchUpdatedOn;
  int? pccBranchIdFk;
  String? pccCreatedOnDate;
  String? pccDailyReadingCreatedOn;
  int? pccDailyReadingId;
  dynamic pccDailyReadingUpdatedOn;
  int? pccId;
  int? pccIdFk;
  String? pccName;
  dynamic pccUpdatedOnDate;
  int? pccUserIdFk;
  int? userBranchIdFk;
  dynamic userCreatedOn;
  String? userEmail;
  int? userId;
  int? userIdFk;
  String? userName;
  dynamic userUpdatedOn;

  Report({
    this.allExhaustFanStatus,
    this.allLightStatusPcc,
    this.allMeterStatusPcc,
    this.bEVolt,
    this.bNVolt,
    this.bRVolt,
    this.loadAmpAcb,
    this.loadAmpMfm,
    this.nEVolt,
    this.powerFactorMfm,
    this.rEVolt,
    this.rNVolt,
    this.rYVolt,
    this.remarkIfAny,
    this.yBVolt,
    this.yEVolt,
    this.yNVolt,
    this.branchCreatedOn,
    this.branchId,
    this.branchIdFk,
    this.branchName,
    this.branchUpdatedOn,
    this.pccBranchIdFk,
    this.pccCreatedOnDate,
    this.pccDailyReadingCreatedOn,
    this.pccDailyReadingId,
    this.pccDailyReadingUpdatedOn,
    this.pccId,
    this.pccIdFk,
    this.pccName,
    this.pccUpdatedOnDate,
    this.pccUserIdFk,
    this.userBranchIdFk,
    this.userCreatedOn,
    this.userEmail,
    this.userId,
    this.userIdFk,
    this.userName,
    this.userUpdatedOn,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    allExhaustFanStatus: json["All_Exhaust_Fan_Status"],
    allLightStatusPcc: json["All_light_Status_PCC"],
    allMeterStatusPcc: json["All_meter_Status_PCC"],
    bEVolt: json["B_E_Volt"],
    bNVolt: json["B_N_Volt"],
    bRVolt: json["B_R_Volt"],
    loadAmpAcb: json["Load_Amp_ACB"],
    loadAmpMfm: json["Load_Amp_MFM"],
    nEVolt: json["N_E_Volt"],
    powerFactorMfm: json["Power_Factor_MFM"],
    rEVolt: json["R_E_Volt"],
    rNVolt: json["R_N_Volt"],
    rYVolt: json["R_Y_Volt"],
    remarkIfAny: json["Remark_If_Any"],
    yBVolt: json["Y_B_Volt"],
    yEVolt: json["Y_E_Volt"],
    yNVolt: json["Y_N_Volt"],
    branchCreatedOn: json["branch_created_on"],
    branchId: json["branch_id"],
    branchIdFk: json["branch_id_fk"],
    branchName: json["branch_name"],
    branchUpdatedOn: json["branch_updated_on"],
    pccBranchIdFk: json["pcc_branch_id_fk"],
    pccCreatedOnDate: json["pcc_created_on_date"],
    pccDailyReadingCreatedOn: json["pcc_daily_reading_created_on"],
    pccDailyReadingId: json["pcc_daily_reading_id"],
    pccDailyReadingUpdatedOn: json["pcc_daily_reading_updated_on"],
    pccId: json["pcc_id"],
    pccIdFk: json["pcc_id_fk"],
    pccName: json["pcc_name"],
    pccUpdatedOnDate: json["pcc_updated_on_date"],
    pccUserIdFk: json["pcc_user_id_fk"],
    userBranchIdFk: json["user_branch_id_fk"],
    userCreatedOn: json["user_created_on"],
    userEmail: json["user_email"],
    userId: json["user_id"],
    userIdFk: json["user_id_fk"],
    userName: json["user_name"],
    userUpdatedOn: json["user_updated_on"],
  );

  Map<String, dynamic> toJson() => {
    "All_Exhaust_Fan_Status": allExhaustFanStatus,
    "All_light_Status_PCC": allLightStatusPcc,
    "All_meter_Status_PCC": allMeterStatusPcc,
    "B_E_Volt": bEVolt,
    "B_N_Volt": bNVolt,
    "B_R_Volt": bRVolt,
    "Load_Amp_ACB": loadAmpAcb,
    "Load_Amp_MFM": loadAmpMfm,
    "N_E_Volt": nEVolt,
    "Power_Factor_MFM": powerFactorMfm,
    "R_E_Volt": rEVolt,
    "R_N_Volt": rNVolt,
    "R_Y_Volt": rYVolt,
    "Remark_If_Any": remarkIfAny,
    "Y_B_Volt": yBVolt,
    "Y_E_Volt": yEVolt,
    "Y_N_Volt": yNVolt,
    "branch_created_on": branchCreatedOn,
    "branch_id": branchId,
    "branch_id_fk": branchIdFk,
    "branch_name": branchName,
    "branch_updated_on": branchUpdatedOn,
    "pcc_branch_id_fk": pccBranchIdFk,
    "pcc_created_on_date": pccCreatedOnDate,
    "pcc_daily_reading_created_on": pccDailyReadingCreatedOn,
    "pcc_daily_reading_id": pccDailyReadingId,
    "pcc_daily_reading_updated_on": pccDailyReadingUpdatedOn,
    "pcc_id": pccId,
    "pcc_id_fk": pccIdFk,
    "pcc_name": pccName,
    "pcc_updated_on_date": pccUpdatedOnDate,
    "pcc_user_id_fk": pccUserIdFk,
    "user_branch_id_fk": userBranchIdFk,
    "user_created_on": userCreatedOn,
    "user_email": userEmail,
    "user_id": userId,
    "user_id_fk": userIdFk,
    "user_name": userName,
    "user_updated_on": userUpdatedOn,
  };
}









