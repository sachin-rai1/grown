import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/home/views/home_view.dart';
import 'package:grown/app/modules/login/views/login_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/data/constants.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      title: "Application",
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: 'assets/images/grown_logo.png',
          nextScreen:await checkLogging()?HomeView():LoginView(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          animationDuration: const Duration(milliseconds: 1500),
          backgroundColor: Colors.white
      ),
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}


Future<bool> checkLogging() async {
  final prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");

  if(prefs.getString("token")  == null){
    return false;
  }
  else if (token != null) {

    bool isTokenExpired = JwtDecoder.isExpired(token);
    log(isTokenExpired.toString());

    if(isTokenExpired ==  true){
      showToastError(msg: "Your Login Expired \nPlease login Again");
      return false;
    }
    else {
      privilage.value = prefs.getString("privilage")!;
      departmentName.value = prefs.getString("user_department_name")!;
      departmentId.value = prefs.getInt("user_department_id")!;
      branchName.value = prefs.getString("user_branch_name")!;
      branchId.value = prefs.getInt("user_branch_id")!;
      return true;
    }


    return true;
  } else {
    return false;
  }
}