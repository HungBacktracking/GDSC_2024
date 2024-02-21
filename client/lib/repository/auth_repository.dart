import 'package:client/ui/pin_authen_register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../models/user_model.dart';
import '../utils/helper.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();

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
                builder: (context) => PinAuthenticationRegister(verificationId: verificationId),
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
    QuerySnapshot querySnapshot = await _firebaseFirestore.collection("users").where("phoneNumber", isEqualTo: phoneNumber).get();
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


}
