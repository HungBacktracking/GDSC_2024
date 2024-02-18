import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  final String stringName;
  final GeoPoint coordinates;

  AddressModel({
    required this.stringName,
    required this.coordinates,
  });

  Map<String, dynamic> toJson() {
    return {
      "stringName": stringName,
      "coordinates": {
        "latitude": coordinates.latitude,
        "longitude": coordinates.longitude,
      }
    };
  }

  static AddressModel fromJson(Map<String, dynamic> map) {
    var latitude = map["coordinates"]["latitude"];
    var longitude = map["coordinates"]["longitude"];
    return AddressModel(
      stringName: map["stringName"],
      coordinates: GeoPoint(
        latitude,
        longitude,
      ),
    );
  }
}
