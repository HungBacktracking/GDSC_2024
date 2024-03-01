import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final GeoPoint coordinates;

  AddressModel({
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return {
      "lat": coordinates.latitude,
      "lng": coordinates.longitude,
    };
  }

  static AddressModel fromJson(Map<String, dynamic> map) {
    var latitude = map["location"]["lat"];
    var longitude = map["location"]["lng"];

    return AddressModel(
      coordinates: GeoPoint(
        latitude,
        longitude,
      ),
    );
  }
}
