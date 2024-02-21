import 'package:cloud_firestore/cloud_firestore.dart';

import 'address_model.dart';

class UserModel {
  String firstName;
  String lastName;
  String profilePic;
  String? createdAt;
  AddressModel? address;
  String phoneNumber;
  bool isBanned;
  String uid;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    this.address,
    this.isBanned = false,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'],
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
    };
  }
}
