import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/maintenance/engineer/views/engineer_view.dart';
import '../../../data/constants.dart';
import '../../../data/widgets.dart';
import '../controllers/maintenance_controller.dart';

class MaintenanceView extends GetView<MaintenanceController> {
  MaintenanceView({Key? key}) : super(key: key);

  final maintenanceController = Get.put(MaintenanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: (privilage.value == "Maintenance Engineer") ? 0 : kToolbarHeight,
          backgroundColor: (privilage.value =="Maintenance Engineer")
              ? Colors.transparent
              : Colors.blue,
          title: (privilage.value =="Maintenance Engineer")
              ? const Text("")
              : const Text("Maintenance"),
          centerTitle: true,
          elevation: 0,
        ),
        body: (privilage.value == "Admin" || privilage.value == "User")
            ? GridView(
                key: controller.gridViewKey,
                controller: controller.scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                ),
                children:List.generate(privilage.value=="User"?controller.userList.length: controller.adminList.length, (index) {
                  return Center(
                      child: (privilage.value == "User")
                          ? SelectCard(choice: controller.userList[index])
                          : SelectCard(choice: controller.adminList[index]));
                }),
              )
            : (privilage.value == "Maintenance Engineer")
                ? EngineerView()
                : Container());
  }
}
