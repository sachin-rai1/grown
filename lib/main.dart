import 'dart:developer'; // Importing the 'developer' module for logging
import 'dart:io'; // Importing the 'io' module for platform-specific operations

import 'package:animated_splash_screen/animated_splash_screen.dart'; // Importing a package for animated splash screen
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart'; // Importing a package for JSON Web Token (JWT) handling
import 'package:firebase_core/firebase_core.dart'; // Importing Firebase Core package
import 'package:flutter/foundation.dart'; // Importing 'foundation' package from Flutter
import 'package:flutter/material.dart'; // Importing Flutter's material package
import 'package:get/get.dart'; // Importing the 'get' package for state management
import 'package:grown/app/modules/home/views/home_view.dart'; // Importing the 'home_view.dart' file
import 'package:grown/app/modules/login/views/login_view.dart'; // Importing the 'login_view.dart' file
import 'package:jwt_decoder/jwt_decoder.dart'; // Importing a package for JWT decoding
import 'package:page_transition/page_transition.dart'; // Importing a package for page transitions
import 'package:permission_handler/permission_handler.dart'; // Importing a package for handling permissions
import 'package:shared_preferences/shared_preferences.dart'; // Importing a package for shared preferences
import 'package:url_launcher/url_launcher.dart'; // Importing a package for launching URLs
import 'app/data/notification_service.dart'; // Importing a custom notification service
import 'app/data/constants.dart'; // Importing a file containing constants
import 'app/routes/app_pages.dart'; // Importing a file containing app routes
import 'firebase_options.dart'; // Importing Firebase options configuration file

// The main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensuring Flutter is initialized

  if (!kIsWeb) {
    // Checking if the app is not running on the web platform
    if (Platform.isAndroid || Platform.isIOS) {
      // Checking if the platform is Android or iOS
      await NotificationService().init(); // Initializing the notification service
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ); // Initializing Firebase with the appropriate options for the current platform
    }
  }

  runApp(
    GetMaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal), // Setting the app's theme
      title: "Application", // Setting the app's title
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: 'assets/images/grown_logo.png', // Setting the splash screen image
          nextScreen: await checkLogging() ? HomeView() : LoginView(), // Determining the next screen based on login status
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.leftToRight,
          animationDuration: const Duration(milliseconds: 1500),
          backgroundColor: Colors.white), // Configuring the animated splash screen
      getPages: AppPages.routes, // Configuring the app's routes
    ),
  );
}

// Function to check if the user is logged in
Future<bool> checkLogging() async {
  if (!kIsWeb) {
    // Checking if the app is not running on the web platform
    if (Platform.isIOS || Platform.isAndroid) {
      // Checking if the platform is iOS or Android
      PermissionStatus status = await Permission.notification.request(); // Requesting notification permission
      if (status.isGranted) {
        log("status granted"); // Logging a message if permission is granted
      } else {
        Permission.notification.request(); // Requesting notification permission if not granted
      }
      await Api.getFirebaseMessagingToken(); // Getting Firebase messaging token
    }
  }

  final prefs = await SharedPreferences.getInstance(); // Getting an instance of shared preferences
  var token = prefs.getString("token"); // Getting the token from shared preferences

  if (prefs.getString("token") == null) {
    return false; // Returning false if the token is null
  } else if (token != null) {
    try {
      final jwt = JWT.verify(token, SecretKey('cat_walking_on_the_street')); // Verifying the JWT
      log('Payload: ${jwt.payload}'); // Logging the JWT payload
    } on JWTExpiredException {
      log('jwt expired'); // Logging a message if the JWT is expired
      return false; // Returning false if the JWT is expired
    } on JWTInvalidException catch (e) {
      log(e.message); // Logging the JWT invalid exception message
      return false; // Returning false if the JWT is invalid
    } on JWTException catch (ex) {
      log(ex.message); // Logging the JWT exception message
      return false; // Returning false if there is a JWT exception
    }

    bool isTokenExpired = JwtDecoder.isExpired(token); // Checking if the token is expired

    log(isTokenExpired.toString()); // Logging the token expiration status

    if (isTokenExpired == true) {
      showToastError(msg: "Your Login Expired \nPlease login Again"); // Showing an error message if the login is expired
      return false; // Returning false if the login is expired
    } else {
      privilage.value = prefs.getString("privilage")!; // Setting the privilege value from shared preferences
      departmentName.value = prefs.getString("user_department_name")!; // Setting the department name from shared preferences
      departmentId.value = prefs.getInt("user_department_id")!; // Setting the department ID from shared preferences
      branchName.value = prefs.getString("user_branch_name")!; // Setting the branch name from shared preferences
      branchId.value = prefs.getInt("user_branch_id")!; // Setting the branch ID from shared preferences
      return true; // Returning true if the user is logged in
    }
  } else {
    return false; // Returning false if the token is null
  }
}

final Uri trushnaUrl = Uri.parse('https://mail.trushnaexim.com'); // Setting the URL

Future<void> launchTrushnaExim() async {
  if (!await launchUrl(trushnaUrl)) {
    throw Exception('Could not launch $trushnaUrl'); // Throwing an exception if the URL cannot be launched
  }
}

final Uri hrmsUrl = Uri.parse('https://hrms.trushnaexim.com'); // Setting the URL

Future<void> launchHrmsUrl() async {
  if (!await launchUrl(hrmsUrl, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $trushnaUrl'); // Throwing an exception if the URL cannot be launched
  }
}
