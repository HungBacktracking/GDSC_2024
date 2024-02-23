import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class MyStyles {
  static const double cornerRadius = 10.0;

  static TextScaler textScaler(BuildContext context) {
    return MediaQuery.of(context).textScaler;
  }

  static TextStyle normalBoldTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: color
    );
  }

  static TextStyle normalTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: color
    );
  }

  static TextStyle smallTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: color
    );
  }

  static TextStyle smallBoldTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color
    );
  }

  static TextStyle largeTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: color
    );
  }

  static TextStyle largeBoldTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: color
    );
  }

  static TextStyle hugeBoldTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color
    );
  }

  static TextStyle hugeTextStyle({Color color = Colors.black}) {
    return TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.normal,
        color: color
    );
  }

  static TextStyle tinyTextStyle({Color color = Colors.black, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: 14,
        fontWeight: fontWeight,
        color: color
    );
  }

  static TextStyle moreTinyTextStyle({Color color = Colors.black, FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(
        fontSize: 12,
        fontWeight: fontWeight,
        color: color
    );
  }


}
