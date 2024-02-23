import 'package:client/api/firebase_api.dart';
import 'dart:convert';
import 'package:client/ui/pin_authen_login_screen.dart';
import 'package:http/http.dart' as http;

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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PinAuthenticationLogin(
                    verificationId: verificationId, phoneNumber: phoneNumber),
              ),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future signUpWithPhone(BuildContext context, String name, int optionVolunteer,
      String phoneNumber) async {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PinAuthenticationRegister(
                    verificationId: verificationId,
                    name: name,
                    optionVolunteer: optionVolunteer,
                    phoneNumber: phoneNumber),
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
        // VERIFY USER SUCCESS
        String? uid = _firebaseAuth.currentUser?.uid;
        if (uid != null) {
          print("Register device token for user: $uid - $userOtp");
          registerDeviceToken(uid);
        }

        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<bool> checkExistingUser(String phoneNumber) async {
    Map<String, dynamic> phoneMap = {"phone_number": phoneNumber};

    String bodyJson = json.encode(phoneMap);
    print("Body Json: $bodyJson");
    final response = await http.post(
      Uri.parse("https://go-echo-server.onrender.com/user/is_exist_phone"),
      headers: {"Content-Type": "application/json"},
      body: bodyJson,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(response.body);
      bool isUserExists = responseData['exists'];

      if (isUserExists) {
        print("USER EXISTS");
        return true;
      } else {
        print("NEW USER");
        return false;
      }
    } else {
      print("Error!!!!");
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
      userModel.id = _firebaseAuth.currentUser!.uid;

      String bodyJson = json.encode(userModel.toMap());
      print("Body Json: $bodyJson");
      final response = await http.post(
        Uri.parse("https://go-echo-server.onrender.com/user/add_user"),
        headers: {"Content-Type": "application/json"},
        body: bodyJson,
      );

      print("Response: $response");

      // Kiểm tra trạng thái phản hồi
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response data: ${response.body}');
        onSuccess();
      } else {
        throw Exception('Failed to create post.');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future<void> registerDeviceToken(String userId) async {
    String? token = await FirebaseAPI().getFirebaseToken();

    if (token != null) {
      Map<String, dynamic> data = {
        'uid': userId,
        'fcm_token': token,
      };

      String body = json.encode(data);

      try {
        final response = await http.post(
          Uri.parse('https://go-echo-server.onrender.com/fcm/add_token'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
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

  Future<void> deleteDeviceToken(String userId) async {
    String? token = await FirebaseAPI().getFirebaseToken();

    if (token != null) {
      Map<String, dynamic> data = {
        'uid': userId,
        'fcm_token': token,
      };

      String body = json.encode(data);

      try {
        http.Response response = await http.post(
          Uri.parse('https://go-echo-server.onrender.com/fcm/delete_token'),
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
