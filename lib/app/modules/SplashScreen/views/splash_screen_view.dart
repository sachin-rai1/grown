import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/modules/home/controllers/home_controller.dart';
import 'package:grown/app/modules/home/views/home_view.dart';
import 'package:page_transition/page_transition.dart';

import '../../login/controllers/login_controller.dart';
import '../../login/views/login_view.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);

  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    // Get.put(LoginController());
    // Get.put(HomeController());

    return AnimatedSplashScreen(
        duration: 3000,
        splash: 'assets/images/grown_logo.png',
        nextScreen: LoginView(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.leftToRight,
        animationDuration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.white
    );
  }
}
