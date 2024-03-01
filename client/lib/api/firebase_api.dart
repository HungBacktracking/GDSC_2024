// import "dart:io";

// import "package:client/api/FCM_provider.dart";
// import "package:client/firebase_options.dart";
// import "package:client/ui/notification_screen.dart";
// import "package:client/ui/sos/helper_notification_screen.dart";
// import "package:firebase_messaging/firebase_messaging.dart";
// import "package:flutter/cupertino.dart";
// import "package:flutter/material.dart";
// import "package:google_maps_flutter/google_maps_flutter.dart";
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:developer';

// import "package:path/path.dart";

// // import 'package:shared_preferences/shared_preferences.dart';

// class FirebaseAPI {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   static NotificationDetails platformChannelSpecifics =
//       const NotificationDetails(
//     android: AndroidNotificationDetails(
//       "high_importance_channel",
//       "High Importance Notifications",
//       priority: Priority.max,
//       importance: Importance.max,
//     ),
//   );

//   Future<void> initNotification() async {
//     await askForPushNotificationPermission();
//     await initializeLocalNotifications();

//     final fcmToken = await getFirebaseToken();
//     print("FCM Token $fcmToken");

//     await registerPushNotificationHandling();
//     // save token to shared preferences
//   }

//   Future<void> askForPushNotificationPermission() async {
//     // You may set the permission requests to "provisional" which allows the user to choose what type
//     // of notifications they would like to receive once the user receives a notification.
//     NotificationSettings settings = await _firebaseMessaging.requestPermission(
//       provisional: true,
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print("User granted permission: ${settings.authorizationStatus}");
//   }

//   Future<void> initializeLocalNotifications() async {
//     const InitializationSettings initSettings = InitializationSettings(
//         // android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//         android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//         iOS: DarwinInitializationSettings());

//     /// on did receive notification response = for when app is opened via notification while in foreground on android
//     await FirebaseAPI._localNotificationsPlugin.initialize(initSettings,
//         onDidReceiveNotificationResponse: (response) {
//       print("onDidReceiveNotificationResponse: $response");
//       FCMProvider.onTapNotification(response);
//     });

//     /// need this for ios foregournd notification
//     await FirebaseAPI._firebaseMessaging
//         .setForegroundNotificationPresentationOptions(
//       alert: true, // Required to display a heads up notification
//       badge: true,
//       sound: true,
//     );
//   }

//   Future<String?> getFirebaseToken() async {
//     return _firebaseMessaging.getToken();
//   }

//   Future<void> registerPushNotificationHandling() async {
//     print("Registering push notification handling");
//     // handle notification when app is in foreground
//     FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
//       handleForegroundMessage(msg);
//     });

//     // open app in terminated state when notification is clicked
//     // FirebaseMessaging.instance.getInitialMessage().then((message) {
//     //   if (message != null) {
//     //     print("getInitMessage: $message");
//     //     FCMProvider.openedAppHandler(message);
//     //   }
//     // });

//     // open app in background state when notification is clicked
//     // FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     //   print("onMessageOpenedApp: ${message.notification!.title}");
//     //   FCMProvider.openedAppHandler(message);
//     // });

//     // handle notification when app is in background
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }

//   Future<void> subscribeToTopic(String topic) async {
//     await _firebaseMessaging.subscribeToTopic(topic);
//   }

//   Future<void> unsubscribeFromTopic(String topic) async {
//     await _firebaseMessaging.unsubscribeFromTopic(topic);
//   }
// }

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print("Handling a background message");

//   FCMProvider.backgroundHandler(message);
// }

// Future<void> handleForegroundMessage(RemoteMessage message) async {
//   print("Handling a foreground message");

//   if (message.notification != null) {
//     print("Title: ${message.notification!.title}");
//     print("Body: ${message.notification!.body}");
//   }

//   if (Platform.isAndroid) {
//     // if this is available when Platform.isIOS, you'll receive the notification twice
//     await FirebaseAPI._localNotificationsPlugin.show(
//       0,
//       message.notification!.title,
//       message.notification!.body,
//       FirebaseAPI.platformChannelSpecifics,
//       payload: message.data.toString(),
//     );
//   }
// }

import 'dart:io';
import 'dart:math';

import 'package:client/models/data_notification.dart';
import 'package:client/ui/sos/helper_notification_screen.dart';
import 'package:client/ui/sos_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }

      if (Platform.isIOS) {
        forgroundMessage();
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    // AndroidNotificationChannel channel = AndroidNotificationChannel(
    //     message.notification!.android!.channelId.toString(),
    //     message.notification!.android!.channelId.toString(),
    //     importance: Importance.max,
    //     showBadge: true,
    //     playSound: true,
    //     sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'));

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "channel_id", "channel name",
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      // sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    print("InteractMessage context: $context");

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("InteractMessage context: $context");
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("HandleMessageForground context: $context");
    DataNotification dataNotification = DataNotification.fromMap(message.data);

    print("DataNotification: $dataNotification");

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HelperNotificationScreen(
                  imageUrl: dataNotification.imageLink,
                  victimLocation: LatLng(
                      dataNotification.location.coordinates.latitude,
                      dataNotification.location.coordinates.longitude),
                )));
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
