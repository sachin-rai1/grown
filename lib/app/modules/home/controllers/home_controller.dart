import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/bcdi_classification/views/bcdi_classification_view.dart';
import 'package:grown/app/modules/bcdi_detection/views/bcdi_detection_view.dart';
import 'package:grown/app/modules/camera_application/views/camera_application_view.dart';
import 'package:grown/app/modules/chiller_reading/views/chiller_reading_view.dart';
import 'package:grown/app/modules/employee_management/views/employee_management_view.dart';
import 'package:grown/app/modules/gas_bank_operator/views/gas_bank_operator_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/views/mlgd_data_monitoring_view.dart';
import '../../../data/constants.dart';
import '../../../data/widgets.dart';
import '../../ups_reading/views/ups_reading_view.dart';

var logic = "abc";
class HomeController extends GetxController {
  final scrollController = ScrollController();

  final gridViewKey = GlobalKey();
  List<Choice> adminList = <Choice>[
    Choice(title: 'BCDI-DETECTION',iconData:Icons.class_sharp, onTap: ()=>Get.to(()=> BcdiDetectionView())),
    Choice(title: 'BCDI-CLASSIFICATION',iconData: Icons.account_tree, onTap: ()=>Get.to(() => BcdiClassificationView())),
    Choice(title: 'CAMERA-APPLICATION',iconData: Icons.camera, onTap: ()=>Get.to(() => CameraApplicationView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',iconData: Icons.people_alt_outlined, onTap: ()=>Get.to(() => EmployeeManagementView())),
    Choice(title: 'GAS BANK OPERATOR',iconData: Icons.comment_bank_sharp, onTap: ()=>Get.to(() => GasBankOperatorView())),
    Choice(title: 'MLGD DATA MONITORING',iconData: Icons.monitor, onTap: ()=>Get.to(() => MlgdDataMonitoringView())),
    Choice(title: 'UPS READING',  iconData: Icons.monitor, onTap: ()=>Get.to(() => UpsReadingView())),
    Choice(title: 'CHILLER READING',iconData: Icons.monitor, onTap: ()=>Get.to(() => ChillerReadingView()))
  ];

  List<Choice> labList = <Choice>[
    Choice(title: 'BCDI-DETECTION',iconData:Icons.class_sharp, onTap: ()=>Get.to(()=> BcdiDetectionView())),
    Choice(title: 'BCDI-CLASSIFICATION',iconData: Icons.account_tree, onTap: ()=>Get.to(() => BcdiClassificationView())),
    Choice(title: 'CAMERA-APPLICATION',iconData: Icons.camera, onTap: ()=>Get.to(() => CameraApplicationView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',iconData: Icons.people_alt_outlined, onTap: ()=>Get.to(() => EmployeeManagementView())),
    Choice(title: 'MLGD DATA MONITORING',iconData: Icons.monitor, onTap: ()=>Get.to(() => MlgdDataMonitoringView())),
  ];

  List<Choice> electricalList = <Choice>[
    Choice(title: 'UPS READING',  iconData: Icons.monitor, onTap: ()=>Get.to(() => UpsReadingView())),
    Choice(title: 'CHILLER READING',iconData: Icons.monitor, onTap: ()=>Get.to(() => ChillerReadingView()))
  ];

  List<Choice> gasList = <Choice>[
    Choice(title: 'GAS BANK OPERATOR',iconData: Icons.comment_bank_sharp, onTap: ()=>Get.to(() => GasBankOperatorView())),
  ];

  List<Choice> itList = <Choice>[];
  List<Choice> nullList = <Choice>[];


}
