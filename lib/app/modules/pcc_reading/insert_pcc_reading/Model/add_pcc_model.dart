import 'dart:convert';

ModelAddPcc modelAddPccFromJson(String str) => ModelAddPcc.fromJson(json.decode(str));

String modelAddPccToJson(ModelAddPcc data) => json.encode(data.toJson());

class ModelAddPcc {
  String? pccName;
  String? branchIdFk;
  String? userIdFk;

  ModelAddPcc({
    this.pccName,
    this.branchIdFk,
    this.userIdFk,
  });

  factory ModelAddPcc.fromJson(Map<String, dynamic> json) => ModelAddPcc(
    pccName: json["pcc_name"],
    branchIdFk: json["branch_id_fk"],
    userIdFk: json["user_id_fk"],
  );

  Map<String, dynamic> toJson() => {
    "pcc_name": pccName,
    "branch_id_fk": branchIdFk,
    "user_id_fk": userIdFk,
  };
}


