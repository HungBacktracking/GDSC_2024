import "package:client/ui/notification_screen.dart";
import "package:client/ui/sos/helper_notification_screen.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:nb_utils/nb_utils.dart";
// import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await askForPushNotificationPermission();

    final fcmToken = await getFirebaseToken();
    print("FCM Token $fcmToken");
    // save token to shared preferences

    registerPushNotificationHandling();
  }

  Future<void> askForPushNotificationPermission() async {
    // You may set the permission requests to "provisional" which allows the user to choose what type
// of notifications they would like to receive once the user receives a notification.
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      provisional: true,
      alert: true,
      badge: true,
      sound: true,
    );

    print("User granted permission: ${settings.authorizationStatus}");
  }

  Future<String?> getFirebaseToken() async {
    return _firebaseMessaging.getToken();
  }

  // Future<void> saveTokenToSharedPreferences(String token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('fcmToken', token);
  // }

  // Future<String?> getTokenFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<void> registerPushNotificationHandling() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // handle notification when app is in foreground
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);

    // open app in terminated state when notification is clicked
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleNotificationOpenedApp(message);
      }
    });

    // open app in background state when notification is clicked
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotificationOpenedApp);

    // handle notification when app is in background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Handling a background message");

  if (message.notification != null) {
    print("Title: ${message.notification!.title}");
    print("Body: ${message.notification!.body}");
  }

  if (message.data.isNotEmpty) {
    handleBackgroundData(message.data);
  }
}

void handleBackgroundData(Map<String, dynamic> data) {
  if (data['type'] == 'location') {}
}

Future<void> handleForegroundMessage(RemoteMessage message) async {
  print("Handling a foreground message");

  if (message.notification != null) {
    print("Title: ${message.notification!.title}");
    print("Body: ${message.notification!.body}");
  }

  if (message.data.isNotEmpty) {
    handleForegroundData(message.data);
  }
}

void handleForegroundData(Map<String, dynamic> data) {}

Future<void> handleNotificationOpenedApp(RemoteMessage? message) async {
  if (message == null) {
    return;
  }

  navigatorKey.currentState!.pushNamed(
    HelperNotificationScreen.routeName,
    arguments: message,
  );

  print("Handling a notification opened app");

  if (message.notification != null) {
    print("Title: ${message.notification!.title}");
    print("Body: ${message.notification!.body}");
  }

  if (message.data.isNotEmpty) {
    handleNotificationOpenedAppData(message.data);
  }
}

void handleNotificationOpenedAppData(Map<String, dynamic> data) {
  print("Data: $data");
}
