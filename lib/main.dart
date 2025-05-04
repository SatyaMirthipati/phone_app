import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_app/custom_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final platform = const MethodChannel('call_channel');

  Future<void> startForegroundService() async {
    await Permission.phone.request();
    try {
      await platform.invokeMethod('startService');
    } catch (e) {
      debugPrint("Failed to start service: $e");
    }
  }

  Future<void> makeCall(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    await launchUrl(uri);
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    PushNotification notification = PushNotification();
    notification.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Call Listener')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: startForegroundService,
                child: const Text('Start Listening to Calls'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => makeCall('1234567890'),
                child: const Text('Make Call'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
