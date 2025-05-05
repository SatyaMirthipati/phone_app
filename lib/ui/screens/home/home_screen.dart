import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/custom_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    startForegroundService();
    PushNotification notification = PushNotification();
    notification.initNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Listener')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Call Listener App'),
          ],
        ),
      ),
    );
  }
}
