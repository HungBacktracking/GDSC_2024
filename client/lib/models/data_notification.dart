import 'package:client/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataNotification {
  String roomId;
  String imageLink;
  AddressModel location;

  DataNotification({
    required this.roomId,
    required this.imageLink,
    required this.location,
  });

  // from map
  factory DataNotification.fromMap(Map<String, dynamic> map) {
    var latitude = double.parse(map["lat"]);
    var longitude = double.parse(map["lng"]);
    var location = AddressModel(
      coordinates: GeoPoint(
        latitude,
        longitude,
      ),
    );

    return DataNotification(
      roomId: map["roomId"],
      imageLink: map["imageLink"],
      location: location,
    );
  }
}
