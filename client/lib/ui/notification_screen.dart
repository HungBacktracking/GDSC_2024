// import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import "package:firebase_messaging/firebase_messaging.dart";

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Title: ${message.notification?.title}'),
          Text('Body: ${message.notification?.body}'),
          Text('Data: ${message.data}')
        ],
      )),
    );
  }
}
