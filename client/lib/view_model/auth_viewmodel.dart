import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/helper.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  AuthViewModel() {
    checkSign();
  }

  void checkSign() async {
    _isSignedIn = await _authRepository.checkSignIn();
    notifyListeners();
  }

  // Future setSignIn() async {
  //   await _authRepository.setSignIn();
  //   _isSignedIn = true;
  //   notifyListeners();
  // }

  Future signInWithPhone(BuildContext context, String phoneNumber) async {
    await _authRepository.signInWithPhone(context, phoneNumber);
    notifyListeners();
  }

  Future signUpWithPhone(BuildContext context, String name, int optionVolunteer, String phoneNumber) async {
    await _authRepository.signUpWithPhone(context, name, optionVolunteer, phoneNumber);
    notifyListeners();
  }

  Future verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    try {
      await _authRepository.verifyOtp(context: context,
          verificationId: verificationId,
          userOtp: userOtp,
          onSuccess: onSuccess);
      notifyListeners();
    } catch (e) {
      getErrorSnackBar("Verification failed!", e);
      notifyListeners();
    }
  }

  Future signInByEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {

    try {
      await _authRepository.signInByEmail(
          context: context,
          email: email,
          password: password);
      notifyListeners();
    } catch (e) {
      getErrorSnackBar("Verification failed!", e);
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser(String phoneNumber) async {
    try {
      return _authRepository.checkExistingUser(phoneNumber);
    } catch (e) {
      return false;
    }
  }

  Future signOut(BuildContext context) async {
    await _authRepository.signOut(context);
  }

  Future saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required Function onSuccess,
  }) async {
    try {
      await _authRepository.saveUserDataToFirebase(context: context, userModel: userModel, onSuccess: onSuccess);
    } catch (e) {
      getErrorSnackBar("Saving user failed!", e);
      notifyListeners();
    }
  }
}
