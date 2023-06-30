import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final NotificationService _notificationService = NotificationService._internal();

  NotificationDetails platformChannelSpecificsConst = NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        ticker: 'ticker',
        channelShowBadge: true,
        enableVibration: true,
        enableLights: true,
        color: Colors.white,
        playSound: true,
        priority: Priority.high,
        vibrationPattern: Int64List.fromList([0, 1000, 200]),
        category: AndroidNotificationCategory.reminder,
        importance: Importance.max,
        channelAction: AndroidNotificationChannelAction.createIfNotExists,
        actions: [
          const AndroidNotificationAction("1", "Mark As Read"),
          const AndroidNotificationAction("2", "Open"),
        ],
      ),
      iOS: const DarwinNotificationDetails());
  NotificationDetails themePlatformChannelSpecificsConst =
  const NotificationDetails(
      iOS: DarwinNotificationDetails(),
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        ticker: 'ticker',
        channelShowBadge: true,
        enableLights: true,
        color: Colors.green,
        enableVibration: false,
        playSound: true,
        priority: Priority.high,
        category: AndroidNotificationCategory.alarm,
        importance: Importance.max,
      ));

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> init() async {
    // await _configureLocalTimezone();
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('grown_logo');

    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    FlutterLocalNotificationsPlugin().initialize(
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:


            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == "2") {
            }
            break;
        }
      },
    );
  }

  showNotification(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(1, title, body, platformChannelSpecificsConst, payload: "data");
  }

  showThemeNotification({required String title, required String body}) async {
    await flutterLocalNotificationsPlugin.show(
        3, title, body, themePlatformChannelSpecificsConst,
        payload: "data");
  }

  showScheduledNotification(int hour, int minute) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        // task.id!.toInt(),
        // task.title,
        // task.note,
        1,
        "",
        "",
        _convertTime(hour, minute),
        platformChannelSpecificsConst,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  showAlarmNotification() async {}

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(const Text("Welcome To Flutter"));
  }

  tz.TZDateTime _convertTime(int hour, int minute) {

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }


    return scheduleDate;
  }

  // Future<void> _configureLocalTimezone() async {
  //   tz.initializeTimeZones();
  //   final String currentTimeZone =
  //   await FlutterNativeTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(currentTimeZone));
  // }
}