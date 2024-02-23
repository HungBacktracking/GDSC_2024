import 'package:client/api/firebase_api.dart';
import 'package:client/ui/pin_authen_register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';
import '../utils/helper.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<bool> checkSignIn() async {
    return (_firebaseAuth.currentUser != null);
  }

  Future signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PinAuthenticationRegister(verificationId: verificationId),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);

      User? user = (await _firebaseAuth.signInWithCredential(creds)).user;
      if (user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<bool> checkExistingUser(String phoneNumber) async {
    QuerySnapshot querySnapshot = await _firebaseFirestore
        .collection("users")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      print("USER EXISTS");
      return true;
    } else {
      print("NEW USER");
      return false;
    }
  }

  Future saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required Function onSuccess,
  }) async {
    try {
      userModel.createdAt = DateTime.now().millisecondsSinceEpoch.toString();
      userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
      userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;

      // uploading to database
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .set(userModel.toMap())
          .then((value) {
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<void> registerDeviceToken(int userId) async {
    String? token = await new FirebaseAPI().getFirebaseToken();

    if (token != null) {
      Map<String, dynamic> data = {
        'uid': userId,
        'fcm_token': token,
      };

      String body = jsonEncode(data);

      try {
        http.Response response = await http.post(
          Uri.parse('localhost:1323/fcm/add_token'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );

        if (response.statusCode == 200) {
          print('Device token registered successfully');
        } else {
          print(
              'Failed to register device token. Error code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error registering device token: $e');
      }
    }
  }

  Future<void> deleteDeviceToken(int userId) async {
    String? token = await new FirebaseAPI().getFirebaseToken();

    if (token != null) {
      Map<String, dynamic> data = {
        'uid': userId,
        'fcm_token': token,
      };

      String body = jsonEncode(data);

      try {
        http.Response response = await http.post(
          Uri.parse('localhost:1323/fcm/delete_token'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );

        if (response.statusCode == 200) {
          print('Device token deleted successfully');
        } else {
          print(
              'Failed to delete device token. Error code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error deleting device token: $e');
      }
    }
  }
}
