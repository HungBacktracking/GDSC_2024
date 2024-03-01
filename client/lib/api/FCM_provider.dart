// import 'package:client/ui/sos_screen.dart';
// import 'package:firebase_messaging/firebase_messaging.dart'
//     show FirebaseMessaging, RemoteMessage;
// import 'package:flutter/widgets.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:developer';
// import 'package:flutter/material.dart';

// class FCMProvider {
//   static BuildContext? _context;
//   static BuildContext? get currentContext => _context;

//   static void setContext(BuildContext context) {
//     FCMProvider._context = context;
//     print("Update FCMProvider context: ${FCMProvider._context}");
//   }

//   /// when app is in the foreground
//   static Future<void> onTapNotification(NotificationResponse? response) async {
//     print("onTapNotification Context: ${FCMProvider.currentContext}");

//     Map<String, String> data = FCMProvider.convertPayload(response!.payload!);
//     print("Data: $data");

//     if (FCMProvider._context == null) return;
//     // handleNotificationOpenedApp(message, FCMProvider._context!);

//     print("Opened app handler");
//     Navigator.of(FCMProvider._context!).push(
//       MaterialPageRoute(builder: (context) {
//         return const SOSScreen();
//       }),
//     );
//   }

//   static Map<String, String> convertPayload(String payload) {
//     final String payload0 = payload.substring(1, payload.length - 1);
//     List<String> split = [];
//     payload0.split(",").forEach((String s) => split.addAll(s.split(":")));
//     Map<String, String> mapped = {};
//     for (int i = 0; i < split.length + 1; i++) {
//       if (i % 2 == 1) {
//         mapped.addAll({split[i - 1].trim().toString(): split[i].trim()});
//       }
//     }
//     return mapped;
//   }

//   static Future<void> openedAppHandler(RemoteMessage message) async {
//     print("OpenAppHandler Context: ${FCMProvider.currentContext}");
//     if (FCMProvider._context == null) return;
//     // handleNotificationOpenedApp(message, FCMProvider._context!);

//     print("Opened app handler");
//     Navigator.of(FCMProvider._context!).push(
//       MaterialPageRoute(builder: (context) {
//         return const SOSScreen();
//       }),
//     );
//   }

//   static Future<void> backgroundHandler(RemoteMessage message) async {
//     if (message.notification != null) {
//       print("Title: ${message.notification!.title}");
//       print("Body: ${message.notification!.body}");
//     }
//   }
// }
