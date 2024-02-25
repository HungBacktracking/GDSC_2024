import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../repository/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository = UserRepository();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getUser(String userId) async {
    
  }
}