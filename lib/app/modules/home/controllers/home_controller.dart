import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/bcdi_classification/views/bcdi_classification_view.dart';
import 'package:grown/app/modules/bcdi_detection/views/bcdi_detection_view.dart';
import 'package:grown/app/modules/camera_application/views/camera_application_view.dart';
import 'package:grown/app/modules/chiller_reading/views/chiller_reading_view.dart';
import 'package:grown/app/modules/employee_management/views/employee_management_view.dart';
import 'package:grown/app/modules/gas_bank_operator/views/gas_bank_operator_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/views/mlgd_data_monitoring_view.dart';
import '../../../data/widgets.dart';
import '../../ups_reading/views/ups_reading_view.dart';

var logic = "abc";
class HomeController extends GetxController {
  final scrollController = ScrollController();

  final gridViewKey = GlobalKey();


  List<Choice> choices = <Choice>[
    Choice(title: 'BCDI-DETECTION',  index: 1 ,iconData:Icons.class_sharp, onTap: ()=>Get.to(()=> BcdiDetectionView())),
    Choice(title: 'BCDI-CLASSIFICATION', index: 2 ,iconData: Icons.account_tree, onTap: ()=>Get.to(() => BcdiClassificationView())),
    Choice(title: 'CAMERA-APPLICATION', index: 2 ,iconData: Icons.camera, onTap: ()=>Get.to(() => CameraApplicationView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT', index: 2 ,iconData: Icons.people_alt_outlined, onTap: ()=>Get.to(() => EmployeeManagementView())),
    Choice(title: 'GAS BANK OPERATOR', index: 2 ,iconData: Icons.comment_bank_sharp, onTap: ()=>Get.to(() => GasBankOperatorView())),
    Choice(title: 'MLGD DATA MONITORING', index: 2 ,iconData: Icons.monitor, onTap: ()=>Get.to(() => MlgdDataMonitoringView())),
    Choice(title: 'UPS READING', index: 2 ,iconData: Icons.monitor, onTap: ()=>Get.to(() => UpsReadingView())),
    Choice(title: 'CHILLER READING', index: 2 ,iconData: Icons.monitor, onTap: ()=>Get.to(() => ChillerReadingView()))
  ];


}
