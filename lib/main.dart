import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/modules/home/views/home_view.dart';
import 'package:grown/app/modules/login/views/login_view.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app/data/constants.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

    try {
      final jwt = JWT.verify(token, SecretKey('cat_walking_on_the_street'));
      log('Payload: ${jwt.payload}');
    } on JWTExpiredException {
      log('jwt expired');
      return false;
    }
    on JWTInvalidException catch(e){
      log(e.message);
      return false;
    }
    on JWTException catch (ex) {
      log(ex.message);
      return false;
    }

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
  } else {
    return false;
  }
}

final Uri trushnaUrl = Uri.parse('https://mail.trushnaexim.com');

Future<void> launchTrushnaExim() async {
  if (!await launchUrl(trushnaUrl)) {
    throw Exception('Could not launch $trushnaUrl');
  }
}

final Uri hrmsUrl = Uri.parse('https://hrms.trushnaexim.com');

Future<void> launchHrmsUrl() async {
  if (!await launchUrl(hrmsUrl, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $trushnaUrl');
  }
}