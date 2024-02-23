import 'package:client/utils/spacer.dart';
import 'package:client/utils/styles.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate padding dynamically based on screen size
    double horizontalMargin = MySpacer.normalHorizontalMargin(context);
    double verticalMargin = MySpacer.normalVerticalMargin(context);
    double largeVerticalHeight = MySpacer.largeHeight(context);
    double normalVerticalHeight = MySpacer.normalHeight(context);
    double smallVerticalHeight = MySpacer.smallHeight(context);

    // Get the text scale factor
    TextScaler textScaler = MyStyles.textScaler(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support Us',
          style: MyStyles.largeBoldTextStyle(),
          textScaler: textScaler,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when the user taps outside the form
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
                'Contact us and we will try our best to resolve your issue.',
                style: MyStyles.largeBoldTextStyle(),
                textScaler: textScaler,
              ),
              SizedBox(height: largeVerticalHeight),
              Text(
                'Email',
                style: MyStyles.largeBoldTextStyle(),
                textScaler: textScaler,
              ),
              SizedBox(height: smallVerticalHeight),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'example@gmail.com',
                  filled: true, // Enable the fill color
                  fillColor: Colors.grey[200], // Fill color
                  border: OutlineInputBorder( // Outline border
                    borderRadius: BorderRadius.circular(MyStyles.cornerRadius),
                    borderSide: BorderSide.none, // No border side
                  ),
                  // Optional: Customize the appearance when the field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(MyStyles.cornerRadius),
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  // Optional: Customize the appearance when the field is enabled but not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(MyStyles.cornerRadius),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                  ),
                ),
                validator: (value) {
                  // Regular expression to validate an email address
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regex = RegExp(pattern);
                  if (value == null || value.isEmpty) {
                    return 'Email cannot be empty'; // Error message when the field is empty
                  } else if (!regex.hasMatch(value)) {
                    return 'Enter a valid email address'; // Error message when the email is invalid
                  } else {
                    return null; // Return null if the input is valid
                  }
                },
              ),
                SizedBox(height: largeVerticalHeight),
              Text(
                'Message',
                style: MyStyles.largeBoldTextStyle(),
                textScaler: textScaler,
              ),
                SizedBox(height: smallVerticalHeight),
              TextFormField(
                maxLines: 10, // Set the maximum number of lines
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Enter Message Here...',
                  filled: true, // Enable the fill color
                  fillColor: Colors.grey[200], // Fill color
                  border: OutlineInputBorder( // Outline border
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border side
                  ),
                  // Optional: Customize the appearance when the field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  // Optional: Customize the appearance when the field is enabled but not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Message cannot be empty'; // Error message for an empty message field
                  }
                  // Optionally, you can add more conditions, like a minimum message length
                  else if (value.trim().length < 10) {
                    return 'Message must be at least 10 characters long'; // Example of a length check
                  }
                  else {
                    return null; // Return null if the input is valid
                  }
                },
              ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(horizontalMargin),
        child: ElevatedButton(
          onPressed: () {/* Submit form logic */},
          style: ElevatedButton.styleFrom(
            minimumSize: Size(screenWidth, 50), // Ensure the button is wide enough
            backgroundColor: MyTheme.submitBtnColor, // Set the background color
            // You can also set the foreground (text) color, if needed
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder( // Set the button's shape
              borderRadius: BorderRadius.circular(MyStyles.cornerRadius), // Rounded corners
            ),
          ),
          child: Text(
              'Submit',
              style: MyStyles.largeBoldTextStyle(color: Colors.white),
              textScaler: textScaler,
          ),
        ),
      ),
    );
  }
}
