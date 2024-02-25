import 'dart:convert';

import 'package:client/models/address_model.dart';

class RoomModel {
  String id;
  String? createdAt;
  String emergencyId;
  String patientId;
  String photoUrl;
  AddressModel location;
  List<String>? participants;
  int status;

  RoomModel({
    required this.id,
    this.createdAt,
    required this.emergencyId,
    required this.patientId,
    required this.photoUrl,
    required this.location,
    List<String>? participants,
    required this.status,
  }) : this.participants = participants ?? [];

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] ?? '',
      createdAt: map['createdAt'] ?? '',
      emergencyId: map['emergencyId'] ?? '',
      patientId: map['patientId'] ?? '',
      location: AddressModel.fromJson(map),
      photoUrl: map['photoUrl'] ?? '',
      participants: map['participants'] != null ? List<String>.from(map['participants']) : null,
      status: map['status'] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'emergencyId': emergencyId,
      'patientId': patientId,
      'photoUrl': photoUrl,
      'location': location.toJson(),
      'participants': participants,
      'status': status,
    };
  }


}