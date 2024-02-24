import 'dart:io';

import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';


void getErrorSnackBar(String message, error) {
  Get.snackbar(
    "Error",
    "$message\n${error.message}",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: MyTheme.redTextColor,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}

void getErrorSnackBarNew(String message) {
  Get.snackbar(
    "Error",
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: MyTheme.redTextColor,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}

void getSuccessSnackBar(String message) {
  Get.snackbar(
    "Success",
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: MyTheme.greenTextColor,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
  );
}

Future<File?> pickImage(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    getErrorSnackBar("Choosing image failed!", e);
  }

  return image;
}

String formatPhoneNumber(String phoneNumber) {
  if (phoneNumber.startsWith('0')) {
    String countryCode = '84';
    phoneNumber = phoneNumber.substring(1);
    phoneNumber = '+$countryCode$phoneNumber';
  }
  return phoneNumber;
}
