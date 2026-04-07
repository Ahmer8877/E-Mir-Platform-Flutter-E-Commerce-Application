import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper with ChangeNotifier {

  //set notification plugin

  static final notification = FlutterLocalNotificationsPlugin();

  //initialize func.

  static  Future<void> initialize() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
        '@mipmap/logo');
    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: android,
        iOS: ios
    );
    await notification.initialize(settings: initializationSettings);

    //permissions condition

         //local notification ke liye
    if(Platform.isAndroid){
      await notification.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

      //schedule noti.. permission

      await notification.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
    }else{
      await notification.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions();
    }
    tz.initializeTimeZones();
  }

  //show func.

   Future<void> show() async{

    AndroidNotificationDetails android=AndroidNotificationDetails('channelId', 'imp.. channel');
    DarwinNotificationDetails ios=DarwinNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(

        android: android,
        iOS: ios
    );
    await notification.show(
        id: Random().nextInt(100),
        title: 'mir_e_platform',
        body: 'Welcome.........',
        notificationDetails: notificationDetails
    );
  }

  //schedule notification

   Future<void> schedule()async{

    AndroidNotificationDetails android=AndroidNotificationDetails(
        'channelId',
        'imp.. channel'
    );
    DarwinNotificationDetails ios=DarwinNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(

        android: android,
        iOS: ios
    );

    await notification.zonedSchedule(
        id: 10,
        title: 'Hoorah!!',
        body: 'just wait and enjoy',
        scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(minutes: 1)),
        notificationDetails: notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}

