import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/employee_management/electrical_employee_management/views/electrical_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/gas_employee_management/views/gas_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/it_employee_management/views/it_employee_management_view.dart';
import 'package:grown/app/modules/employee_management/lab_employee_management/views/lab_employee_management_view.dart';

import '../../../data/widgets.dart';

class EmployeeManagementController extends GetxController {
  final scrollController = ScrollController();

  final gridViewKey = GlobalKey();


  List<Choice> choices = <Choice>[
    Choice(title: 'LAB EMPLOYEE MANAGEMENT',  index: 1 ,iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  LabEmployeeManagementView())),
    Choice(title: 'GAS EMPLOYEE MANAGEMENT',  index: 1 ,iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  GasEmployeeManagementView())),
    Choice(title: 'IT EMPLOYEE MANAGEMENT',  index: 1 ,iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  ItEmployeeManagementView())),
    Choice(title: 'ELECTRICAL EMPLOYEE MANAGEMENT',  index: 1 ,iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  ElectricalEmployeeManagementView())),
  ];
}
