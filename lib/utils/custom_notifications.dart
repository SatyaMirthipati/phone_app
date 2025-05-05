import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class PushNotification {
  void initNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'lift_call') {
          const platform = MethodChannel('com.phone.app/call');
          platform.invokeMethod('liftCall');
        }
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showCallNotification(message.notification?.title ?? "Incoming Call");
    });
  }

  void showCallNotification(String caller) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'call_channel',
      'Call Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'lift',
          'Lift Call',
          showsUserInterface: true,
        ),
      ],
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Incoming Call',
      '$caller is calling...',
      platformDetails,
      payload: 'lift_call',
    );
  }
}
