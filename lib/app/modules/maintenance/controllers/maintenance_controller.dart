import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/maintenance/assign_engineer/views/assign_engineer_view.dart';
import 'package:grown/app/modules/maintenance/edit_assigned_engineer/views/edit_assigned_engineer_view.dart';
import 'package:grown/app/modules/maintenance/engineer/views/engineer_view.dart';
import 'package:grown/app/modules/maintenance/register_complain/views/register_complain_view.dart';
import 'package:grown/app/modules/maintenance/view_complain/views/view_complain_view.dart';

import '../../../data/widgets.dart';

class MaintenanceController extends GetxController {
  final scrollController = ScrollController();

  final gridViewKey = GlobalKey();

  List<Choice> adminList = <Choice>[
    Choice(title: 'Register Complain',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  RegisterComplainView())),
    Choice(title: 'View Complain',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>   ViewComplainView())),
    Choice(title: 'Assign Engineer',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>   AssignEngineerView())),
    Choice(title: 'Edit Assigned Engineer',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>   EditAssignedEngineerView())),

    Choice(title: 'Engineers',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>   EngineerView())),
  ];

  List<Choice> userList = <Choice>[
    Choice(title: 'Register Complain',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>  RegisterComplainView())),
    Choice(title: 'View Complain',  iconData:Icons.class_sharp, onTap: ()=>Get.to(()=>   ViewComplainView())),
  ];

}
