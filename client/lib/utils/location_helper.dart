import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location2D {
  double latitude;
  double longitude;
  Position? position;
  Location2D({required this.latitude, required this.longitude, this.position});
}

class LocationHelper {
  BuildContext? context;

  LocationHelper(this.context);

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<Location2D?> myLocation() async {
    // return the location of the user
    // Check location permission
    bool permission = await _handleLocationPermission();

    if (permission) {
      // Permission granted, proceed to get the location
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        double latitude = position.latitude;
        double longitude = position.longitude;
        // Use the latitude and longitude values as needed
        print('Latitude: $latitude, Longitude: $longitude');
        return Location2D(
            latitude: latitude, longitude: longitude, position: position);
      } catch (e) {
        // Handle any errors that occur during location retrieval
        print('Error getting location: $e');
        return null;
      }
    }

    return null;
  }

  Future<List<Placemark>> getAddressFromLocation(Position position) async {
    // return the address of the user from the location
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemarks;
    } catch (e) {
      print('Error getting address from location: $e');
      return [];
    }
  }

  static void updateLocationToServer(int userId, Location2D location) {
    // update the location of the user to the server
    Map<String, dynamic> data = {
      'uid': userId,
      'latitude': location.latitude,
      'longitude': location.longitude,
    };

    String body = jsonEncode(data);
    try {
      http.post(Uri.parse('https://example.com/update-location'),
          body: body,
          headers: {
            'Content-Type': 'application/json',
          });
    } catch (e) {
      print('Error updating location to server: $e');
    }
  }
}
