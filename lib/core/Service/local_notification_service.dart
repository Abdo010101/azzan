import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:azzan/Features/HomeFeature/presentaion/cubit/home_cubit.dart';
import 'package:azzan/core/Network/di.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class LocalNotificationService {
  //!Noticication two parts push and local
  //! 1-  local appear form my devixe
  //!/-  push appear form my server
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse details) {}

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings('icon'),
        iOS: DarwinInitializationSettings());
    flutterLocalNotificationsPlugin.initialize(settings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap);
  }

  //! this function cancel notiftion
  void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  //!   Secduled Notification

  static void secduledNotification(
      {required DateTime prayerTime, required String prayerName}) async {
    tz.initializeTimeZones();
    tz.TZDateTime scheduledDate = tz.TZDateTime.from(prayerTime, tz.local);
//! here we can handle the azzan music for fajr or not#{v}

    //* this notification for azzan of fajr time
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'prayer_channel',
      'Prayer Notifications',
      channelDescription: 'Notification for prayer times',
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('sound'),
      playSound: true,
      showWhen: true,
    );
    NotificationDetails details = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    details = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
        prayerName.hashCode, // prayerName.hashCode,
        'Payer Time',
        'It is Time For ${prayerName}  prayer',
        scheduledDate,
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
