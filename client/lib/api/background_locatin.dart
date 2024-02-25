import 'package:client/api/server_api.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BackgroundLocationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Location location = Location();
  int _interval = 5000;
  double _distance = 10;

  BackgroundLocationService({int interval = 5000, double distanceFilter = 10}) {
    _interval = interval;
    _distance = distanceFilter;

    initialize();
  }

  void requestLocation() async {
    bool serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void initialize() {
    requestLocation();
  }

  Future<LocationData> getLocation() async {
    return location.getLocation();
  }

  void sendLocationToServer(LocationData location) {
    String uid = "";
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      uid = auth.currentUser!.uid;
    } catch (e) {
      print(e);
    }

    if (uid == "") {
      print("User not logged in");
      return;
    }

    print("Sending location to server with uid: $uid");

    try {
      // Send location to server
      Map<String, dynamic> data = {
        'uid': uid,
        'latitude': location.latitude,
        'longitude': location.longitude,
      };

      String bodyJson = json.encode(data);

      print(
          "Location data to server(${ServerAPI().updateLocation()}): $bodyJson");

      http.post(
        Uri.parse(ServerAPI().updateLocation()),
        headers: {"Content-Type": "application/json"},
        body: bodyJson,
      );
    } catch (e) {
      print(e);
    }
  }

  void handleLocationChange(LocationData locationData) async {
    print('Location changed: $locationData');
    sendLocationToServer(locationData);
  }

  Future<bool> isLocationServiceEnabled() async {
    return await location.serviceEnabled();
  }

  void turnOnBackgroundLocationService() {
    location.enableBackgroundMode(enable: true);
  }

  void turnOffBackgroundLocationService() {
    location.enableBackgroundMode(enable: false);
  }

  void turnOnService() {
    requestLocation();

    location.changeSettings(interval: _interval, distanceFilter: _distance);

    location.changeNotificationOptions(
      title: "Background location",
      iconName: "mipmap/ic_launcher",
      subtitle: "we are tracking your location",
      description: "This app is running in background to track your location",
      color: Colors.blueAccent,
      onTapBringToFront: true,
    );

    location.onLocationChanged.listen(handleLocationChange);

    turnOnBackgroundLocationService();
  }

  void turnOffService() {
    location.changeSettings(interval: 60000, distanceFilter: 10);
    location.onLocationChanged.listen((LocationData locationData) {});
    turnOffBackgroundLocationService();
  }

  void dispose() {
    turnOffService();
  }
}
