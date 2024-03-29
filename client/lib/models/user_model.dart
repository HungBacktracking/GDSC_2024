import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

class UserModel {
  String name;
  String? profilePic;
  String? createdAt;
  AddressModel? location;
  String phoneNumber;
  bool isBanned;
  bool isActive;
  bool isVolunteer;
  String id;

  UserModel({
    required this.name,
    this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.id,
    this.location,
    this.isBanned = false,
    this.isActive = true,
    this.isVolunteer = false,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      id: map['id'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      location: AddressModel.fromJson(map),
      profilePic: map['avatar'] ?? '',
      isBanned: map['isBanned'] ?? false,
      isActive: map['isActive'] ?? true,
      isVolunteer: map['isVolunteer'] ?? false,
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "displayName": name,
      "avatar": profilePic,
      "isActive": isActive,
      "isBanned": isBanned,
      "isVolunteer": isVolunteer,
      "location": location!.toJson(),
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}
