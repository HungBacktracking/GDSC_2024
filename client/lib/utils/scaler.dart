import 'package:flutter/widgets.dart';

class Scaler {
  static final Scaler _instance = Scaler._privateConstructor();
  double _widthScaleFactor = 1.0;
  double _heightScaleFactor = 1.0;
  double _textScaleFactor = 1.0;
  // Private constructor
  Scaler._privateConstructor();

  // Factory constructor to return the instance
  factory Scaler() {
    return _instance;
  }

  // Initialization method to be called with a BuildContext
  void init(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaler = MediaQuery.of(context).textScaler;
    _widthScaleFactor = screenWidth / 411.42857142857144;
    _heightScaleFactor = screenHeight / 867.4285714285714;
    _textScaleFactor = textScaler.scale(10.0)/10.0;
  }

  double get widthScaleFactor => _widthScaleFactor;
  double get heightScaleFactor => _heightScaleFactor;
  double get textScaleFactor => _textScaleFactor;
}