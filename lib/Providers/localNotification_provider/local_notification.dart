import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper with ChangeNotifier {

  static final notification = FlutterLocalNotificationsPlugin();

  static  Future<void> initialize() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
        '@mipmap/logo');
    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: android,
        iOS: ios
    );
    await notification.initialize(settings: initializationSettings);

    if(Platform.isAndroid){
      await notification.resolvePlatformSpecificImplementation
      <AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    }else{
      await notification.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions();
    }
  }

   Future<void> show() async{

    AndroidNotificationDetails android=AndroidNotificationDetails('channelId', 'imp.. channel');
    DarwinNotificationDetails ios=DarwinNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(

        android: android,
        iOS: ios
    );
    await notification.show(
        id: 100,
        title: 'mir_e_platform',
        body: 'Welcome.........',
        notificationDetails: notificationDetails
    );
  }
}

