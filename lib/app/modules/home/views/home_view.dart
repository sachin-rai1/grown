import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/login/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            logoutDialogBox(context); // Function call to show a logout dialog box
          },
          icon: const Icon(Icons.exit_to_app),
          iconSize: 30,
          color: Colors.black87,
        ),
        elevation: 0,
        title: const Text("Welcome to Grown App"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        key: controller.gridViewKey, // Setting a key for the GridView
        controller: controller.scrollController, // Setting a scroll controller for the GridView
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveNew.isMobile(context)
              ? 2
              : ResponsiveNew.isTablet(context)
              ? 3
              : 4, // Determining the number of columns based on the device's screen size
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
        ),
        children: List.generate(
          (departmentName.value == "Admin")
              ? controller.adminList.length
              : (departmentName.value == "Lab")
              ? controller.labList.length
              : (departmentName.value == "IT")
              ? controller.itList.length
              : (departmentName.value == "GAS")
              ? controller.gasList.length
              : (departmentName.value == "ELECTRICAL")
              ? controller.electricalList.length
              : 0, // Generating a list of items based on the department name
              (index) {
            return Center(
              child: Card(
                elevation: 2,
                color: Colors.white,
                child: SelectCard(
                  choice: (departmentName.value == "Admin")
                      ? controller.adminList[index]
                      : (departmentName.value == "Lab")
                      ? controller.labList[index]
                      : (departmentName.value == "IT")
                      ? controller.itList[index]
                      : (departmentName.value == "GAS")
                      ? controller.gasList[index]
                      : (departmentName.value == "ELECTRICAL")
                      ? controller.electricalList[index]
                      : controller.nullList[index], // Passing the appropriate item based on the department name
                ),
              ),
            );
          },
        ),
      ),
    );

  }

  void logoutDialogBox(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () async {
            final preferences = await SharedPreferences.getInstance();
            await preferences.clear(); // Clearing the shared preferences
            await Get.offAll(() => LoginView()); // Navigating to the LoginView screen
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.green,
          ),
          child: const Text("Yes"),
        ),
        ElevatedButton(
          onPressed: () => Get.back(), // Closing the dialog box
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.red,
          ),
          child: const Text("No"),
        )
      ],
      content: const Text("Are You Sure Want to Logout ?"),
    );

    showDialog(
      context: context,
      builder: (context) {
        return alertDialog; // Showing the dialog box
      },
    );
  }

}
