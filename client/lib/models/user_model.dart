import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

class UserModel {
  String name;
  String? profilePic;
  String? createdAt;
  AddressModel? address;
  String phoneNumber;
  bool isBanned;
  bool isActive;
  bool isVolunteer;
  String? id;

  UserModel({
    required this.name,
    this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    this.id,
    this.address,
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
      "displayName": name,
      "avatar": profilePic,
      "isActive": isActive,
      "isBanned": isBanned,
      "isVolunteer": isVolunteer,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}
