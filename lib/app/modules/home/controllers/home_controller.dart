import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/bcdi_classification/views/bcdi_classification_view.dart';
import 'package:grown/app/modules/bcdi_detection/views/bcdi_detection_view.dart';
import 'package:grown/app/modules/chiller_reading/views/chiller_reading_view.dart';
import 'package:grown/app/modules/email_config/views/email_config_view.dart';
import 'package:grown/app/modules/employee_management/views/employee_management_view.dart';
import 'package:grown/app/modules/feedback/views/feedback_view.dart';
import 'package:grown/app/modules/gas_bank_operator/views/gas_bank_operator_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/views/mlgd_data_monitoring_view.dart';
import 'package:grown/app/modules/user_management/views/user_management_view.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../main.dart';
import '../../../data/widgets.dart';
import '../../maintenance/views/maintenance_view.dart';
import '../../ups_reading/views/ups_reading_view.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();// Scroll controller for GridView scrolling


  final gridViewKey = GlobalKey();  // Key for accessing the GridView widget
  String appVersion = "";
  String appName = '';

  void package() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    appName = packageInfo.appName;
  }

  @override
  void onInit(){
    super.onInit();
    package();
  }


// List of choices for the admin department
  List<Choice> adminList = <Choice>[
    Choice(
        title: 'BCDI-DETECTION',
        image: "assets/images/detection1.png",
        onTap: () => Get.to(() => BcdiDetectionView())),
    Choice(
        title: 'BCDI-CLASSIFICATION',
        image: "assets/images/classification.png",
        onTap: () => Get.to(() => BcdiClassificationView())),
    Choice(
        title: 'EMPLOYEE-MANAGEMENT',
        image: "assets/images/empManagement.png",
        onTap: () => Get.to(() => EmployeeManagementView())),
    Choice(
        title: 'GAS BANK OPERATOR',
        image: "assets/images/gas.png",
        onTap: () => Get.to(() => GasBankOperatorView())),
    Choice(
        title: 'LAB GROWING PROCESS',
        image: "assets/images/mlgd.png",
        onTap: () => Get.to(() => MlgdDataMonitoringView())),
    Choice(
        title: 'UPS READING',
        image: "assets/images/ups.png",
        onTap: () => Get.to(() => UpsReadingView())),
    Choice(
        title: 'CHILLER READING',
        image: "assets/images/chiller.png",
        onTap: () => Get.to(() => ChillerReadingView())),
    Choice(
        title: 'Maintenance',
        iconData: Icons.settings,
        onTap: () => Get.to(() => MaintenanceView())),
    Choice(
        title: 'Trushna Exim Mail',
        iconData: Icons.mail,
        iconColor: Colors.red,
        onTap: () => launchTrushnaExim()),
    Choice(
        title: 'HRMS',
        image: "assets/images/trushnaexim.png",
        iconColor: Colors.red,
        onTap: () => launchHrmsUrl()),
    Choice(
        title: 'User Management',
        iconData: Icons.supervised_user_circle_rounded,
        iconColor: Colors.green,
        onTap: () => Get.to(() => const UserManagementView())),
    Choice(
        title: 'Feedback',
        iconData: Icons.feedback_sharp,
        iconColor: Colors.blue,
        onTap: () => Get.to(() =>  FeedbackView())),
    Choice(
        title: 'Email Setting',
        iconData: Icons.email_sharp,
        iconColor: Colors.red,
        onTap: () => Get.to(() =>  EmailConfigView())),
  ];

  // List of choices for the lab department
  List<Choice> labList = <Choice>[
    Choice(
        title: 'BCDI-DETECTION',
        image: "assets/images/detection1.png",
        onTap: () => Get.to(() => BcdiDetectionView())),
    Choice(
        title: 'BCDI-CLASSIFICATION',
        image: "assets/images/classification.png",
        onTap: () => Get.to(() => BcdiClassificationView())),
    Choice(
        title: 'EMPLOYEE-MANAGEMENT',
        image: "assets/images/empManagement.png",
        onTap: () => Get.to(() => EmployeeManagementView())),
    Choice(
        title: 'LAB GROWING PROCESS',
        image: "assets/images/mlgd.png",
        onTap: () => Get.to(() => MlgdDataMonitoringView())),
    Choice(
        title: 'Maintenance',
        iconData: Icons.settings,
        onTap: () => Get.to(() => MaintenanceView())),
  ];

  // List of choices for the electrical department
  List<Choice> electricalList = <Choice>[
    Choice(
        title: 'UPS READING',
        image: "assets/images/ups.png",
        onTap: () => Get.to(() => UpsReadingView())),
    Choice(
        title: 'CHILLER READING',
        image: "assets/images/chiller.png",
        onTap: () => Get.to(() => ChillerReadingView())),
    Choice(
        title: 'EMPLOYEE-MANAGEMENT',
        image: "assets/images/empManagement.png",
        onTap: () => Get.to(() => EmployeeManagementView())),
  ];

  // List of choices for the gas department
  List<Choice> gasList = <Choice>[
    Choice(
        title: 'GAS BANK OPERATOR',
        image: "assets/images/gas.png",
        onTap: () => Get.to(() => GasBankOperatorView())),
    Choice(
        title: 'EMPLOYEE-MANAGEMENT',
        image: "assets/images/empManagement.png",
        onTap: () => Get.to(() => EmployeeManagementView())),
  ];

  // List of choices for the IT department
  List<Choice> itList = <Choice>[
    Choice(
        title: 'EMPLOYEE-MANAGEMENT',
        image: "assets/images/empManagement.png",
        onTap: () => Get.to(() => EmployeeManagementView())),
  ];
  List<Choice> nullList = <Choice>[];

}
