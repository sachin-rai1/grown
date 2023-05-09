import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/bcdi_classification/views/bcdi_classification_view.dart';
import 'package:grown/app/modules/bcdi_detection/views/bcdi_detection_view.dart';
import 'package:grown/app/modules/camera_application/views/camera_application_view.dart';
import 'package:grown/app/modules/chiller_reading/views/chiller_reading_view.dart';
import 'package:grown/app/modules/employee_management/views/employee_management_view.dart';
import 'package:grown/app/modules/gas_bank_operator/views/gas_bank_operator_view.dart';
import 'package:grown/app/modules/mlgd_data_monitoring/MlgdBottomNavigation/views/mlgd_bottom_navigation_view.dart';
import '../../../data/widgets.dart';
import '../../ups_reading/views/ups_reading_view.dart';

var logic = "abc";
class HomeController extends GetxController {
  final scrollController = ScrollController();

  final gridViewKey = GlobalKey();
  List<Choice> adminList = <Choice>[
    Choice(title: 'BCDI-DETECTION',image: "assets/images/detection1.png", onTap: ()=>Get.to(()=> BcdiDetectionView())),
    Choice(title: 'BCDI-CLASSIFICATION',image: "assets/images/classification.png", onTap: ()=>Get.to(() => BcdiClassificationView())),
    Choice(title: 'CAMERA-APPLICATION',image: "assets/images/camera_app.png", onTap: ()=>Get.to(() => CameraApplicationView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',image: "assets/images/empManagement.png", onTap: ()=>Get.to(() => EmployeeManagementView())),
    Choice(title: 'GAS BANK OPERATOR',image: "assets/images/gas.png", onTap: ()=>Get.to(() => GasBankOperatorView())),
    Choice(title: 'MLGD DATA MONITORING',image: "assets/images/mlgd.png", onTap: ()=>Get.to(() => const MlgdBottomNavigationView())),
    Choice(title: 'UPS READING',image: "assets/images/ups.png",   onTap: ()=>Get.to(() => UpsReadingView())),
    Choice(title: 'CHILLER READING',image: "assets/images/chiller.png", onTap: ()=>Get.to(() => ChillerReadingView()))
  ];

  List<Choice> labList = <Choice>[
    Choice(title: 'BCDI-DETECTION',image: "assets/images/detection1.png", onTap: ()=>Get.to(()=> BcdiDetectionView())),
    Choice(title: 'BCDI-CLASSIFICATION',image: "assets/images/classification.png", onTap: ()=>Get.to(() => BcdiClassificationView())),
    Choice(title: 'CAMERA-APPLICATION',image: "assets/images/camera_app.png", onTap: ()=>Get.to(() => CameraApplicationView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',image: "assets/images/empManagement.png", onTap: ()=>Get.to(() => EmployeeManagementView())),
    Choice(title: 'MLGD DATA MONITORING',image: "assets/images/mlgd.png", onTap: ()=>Get.to(() => const MlgdBottomNavigationView())),
  ];

  List<Choice> electricalList = <Choice>[
    Choice(title: 'UPS READING',image: "assets/images/ups.png",   onTap: ()=>Get.to(() => UpsReadingView())),
    Choice(title: 'CHILLER READING',image: "assets/images/chiller.png", onTap: ()=>Get.to(() => ChillerReadingView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',image: "assets/images/empManagement.png", onTap: ()=>Get.to(() => EmployeeManagementView())),
  ];

  List<Choice> gasList = <Choice>[
    Choice(title: 'GAS BANK OPERATOR',image: "assets/images/gas.png", onTap: ()=>Get.to(() => GasBankOperatorView())),
    Choice(title: 'EMPLOYEE-MANAGEMENT',image: "assets/images/empManagement.png", onTap: ()=>Get.to(() => EmployeeManagementView())),
  ];

  List<Choice> itList = <Choice>[
    Choice(title: 'EMPLOYEE-MANAGEMENT',image: "assets/images/empManagement.png", onTap: ()=>Get.to(() => EmployeeManagementView())),
  ];
  List<Choice> nullList = <Choice>[];


}
