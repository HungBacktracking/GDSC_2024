import 'package:flutter/material.dart';

class MySpacer {
  // Method to get small spacing
  static double smallHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.01; // Example: 1% of screen height
  }

  // Method to get normal spacing
  static double normalHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.02; // Example: 2% of screen height
  }

  // Method to get large spacing
  static double largeHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.03; // Example: 3% of screen height
  }

  //for width
  static double smallWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.01; // Example: 1% of screen width
  }

  static double normalWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.02; // Example: 2% of screen width
  }

  static double largeWidth(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.03; // Example: 3% of screen width
  }

  //for horizontal padding
  static double smallHorizontalMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.02; // Example: 1% of screen width
  }

  static double normalHorizontalMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.04; // Example: 2% of screen width
  }

  static double largeHorizontalMargin(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth * 0.05; // Example: 3% of screen width
  }

  //for vertical padding
  static double smallVerticalMargin(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.01; // Example: 1% of screen height
  }

  static double normalVerticalMargin(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.02; // Example: 2% of screen height
  }

  static double largeVerticalMargin(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight * 0.04; // Example: 3% of screen height
  }
}
