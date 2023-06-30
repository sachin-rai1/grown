class Parent {
  final int averageLoad;
  final int branchId;
  final int chillerId;
  final dynamic circulationPump1Status;
  final dynamic circulationPump2Status;
  final DateTime? createdOn;
  final int inletTemperature;
  final int outletTemperature;
  final int phaseId;
  final int readingId;
  final DateTime? updatedOn;

  Parent({
    required this.averageLoad,
    required this.branchId,
    required this.chillerId,
    required this.circulationPump1Status,
    required this.circulationPump2Status,
    required this.createdOn,
    required this.inletTemperature,
    required this.outletTemperature,
    required this.phaseId,
    required this.readingId,
    required this.updatedOn,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      averageLoad: json['average_load'],
      branchId: json['branch_id'],
      chillerId: json['chiller_id'],
      circulationPump1Status: json['circulation_pump_1_status'],
      circulationPump2Status: json['circulation_pump_2_status'],
      createdOn: json['created_on'],
      inletTemperature: json['inlet_temperature'],
      outletTemperature: json['outlet_temperature'],
      phaseId: json['phase_id'],
      readingId: json['reading_id'],
      updatedOn: json['updated_on'],
    );
  }
}

class Child {
  final int ccrId;
  final int compressorId;
  final int crId;
  final int status;

  Child({
    required this.ccrId,
    required this.compressorId,
    required this.crId,
    required this.status,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      ccrId: json['ccr_id'],
      compressorId: json['compressor_id'],
      crId: json['cr_id'],
      status: json['status'],
    );
  }
}

class ParentChildData {
  final List<Parent> parents;
  final List<Child> children;

  ParentChildData({
    required this.parents,
    required this.children,
  });

  factory ParentChildData.fromJson(Map<String, dynamic> json) {
    final parentList = (json['parent'] as List)
        .map((item) => Parent.fromJson(item))
        .toList();

    final childList = (json['children'] as List)
        .map((item) => Child.fromJson(item))
        .toList();

    return ParentChildData(
      parents: parentList,
      children: childList,
    );
  }
}


