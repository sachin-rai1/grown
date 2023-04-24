import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/widgets.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Welcome to Grown App"),
        centerTitle: true,
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        key:controller.gridViewKey,
        controller:controller.scrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 15,
        ),
        children: List.generate(controller.choices.length, (index) {
        return Center(child: SelectCard(choice:controller.choices[index]));
      }),
      ),
    );
  }
}





