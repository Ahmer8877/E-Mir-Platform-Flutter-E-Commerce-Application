import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {

  static final notification = FlutterLocalNotificationsPlugin();

  static  Future<void> initialize() async {
    AndroidInitializationSettings android = AndroidInitializationSettings(
        '@mipmap/img');
    DarwinInitializationSettings ios = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: android,
        iOS: ios
    );
    await notification.initialize(settings: initializationSettings);
  }

  static Future<void> show() async{

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

