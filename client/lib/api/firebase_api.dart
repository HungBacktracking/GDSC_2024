import "package:firebase_messaging/firebase_messaging.dart";

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Message also contained a notification: ${message.notification}");
    print("Title: ${message.notification!.title}");
    print("Body: ${message.notification!.body}");
  }

  if (message.data != null) {
    print("Message also contained data: ${message.data}");
  }
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await configureFirebase();

    final fcmToken = await getFirebaseToken();
    print("FCM Token: $fcmToken");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage received");
      handleBackgroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp received");
      handleBackgroundMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<String?> getFirebaseToken() async {
    return _firebaseMessaging.getToken();
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> configureFirebase() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
