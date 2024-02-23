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
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

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
    try {
      await _authRepository.signInWithPhone(context, phoneNumber);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future signUpWithPhone(BuildContext context, String name, int optionVolunteer, String phoneNumber) async {
    try {
      await _authRepository.signUpWithPhone(context, name, optionVolunteer, phoneNumber);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  Future verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.verifyOtp(context: context,
          verificationId: verificationId,
          userOtp: userOtp,
          onSuccess: onSuccess);
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> checkExistingUser(String phoneNumber) async {
    try {
      return _authRepository.checkExistingUser(phoneNumber);
    } catch (e) {
      print(e.toString());
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
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.saveUserDataToFirebase(context: context, userModel: userModel, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}
