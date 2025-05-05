# phone_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# 📱 Phone Call Listener App (Flutter + Kotlin)

This Flutter app detects **incoming** and **outgoing** calls on Android devices, shows local notifications for each call event, and works even when the app is in the background or closed.

> ⚠️ **iOS support is not possible** due to strict Apple policies around accessing call state.

---

## 🛠️ Features

- Detect incoming call ringing
- Detect outgoing calls
- Detect call answered and ended
- Show local notifications using `flutter_local_notifications`
- Foreground Kotlin service to ensure call state is monitored in background

---

## 📂 Project Structure

phone_app/
├── android/
│ └── app/
│ └── src/
│ └── main/
│ └── kotlin/
│ └── phone/
│ └── app/
│ └── phone_app/
│ ├── CallReceiver.kt
│ └── CallForegroundService.kt
├── lib/
│ └── main.dart
├── pubspec.yaml
└── README.md
