import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Support Us',
          style: TextStyle(
            fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25.0 * scaler.widthScaleFactor),
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
            padding: EdgeInsets.symmetric(horizontal: 15.0 * scaler.widthScaleFactor , vertical: 16 * scaler.heightScaleFactor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Contact us and we will try our best to resolve your issue.',
                  style: TextStyle(
                    fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 25 * scaler.widthScaleFactor),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10 * scaler.widthScaleFactor),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'example@gmail.com',
                    labelStyle: TextStyle(
                      fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.grey[600],
                    ),
                    filled: true, // Enable the fill color
                    fillColor: Colors.grey[200], // Fill color
                    border: OutlineInputBorder( // Outline border
                      borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
                      borderSide: BorderSide.none, // No border side
                    ),
                    // Optional: Customize the appearance when the field is focused
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0 * scaler.widthScaleFactor),
                    ),
                    // Optional: Customize the appearance when the field is enabled but not focused
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0 * scaler.widthScaleFactor),
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
                SizedBox(height: 20 * scaler.widthScaleFactor),
                Text(
                  'Message',
                  style: TextStyle(
                    fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10 * scaler.widthScaleFactor),
                TextFormField(
                  style: TextStyle(
                    fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    color: Colors.black,
                  ),
                  maxLines: 10, // Set the maximum number of lines
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Enter Message Here...',
                    labelStyle: TextStyle(
                      fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.grey[600],
                    ),
                    suffixStyle: TextStyle(
                      fontSize: 16.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.grey[600],
                    ),

                    filled: true, // Enable the fill color
                    fillColor: Colors.grey[200], // Fill color
                    border: OutlineInputBorder( // Outline border
                      borderRadius: BorderRadius.circular(8.0 * scaler.widthScaleFactor),
                      borderSide: BorderSide.none, // No border side
                    ),
                    // Optional: Customize the appearance when the field is focused
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0 * scaler.widthScaleFactor),
                      borderSide: BorderSide(color: Colors.blue, width: 2.0 * scaler.widthScaleFactor),
                    ),
                    // Optional: Customize the appearance when the field is enabled but not focused
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0 * scaler.widthScaleFactor),
                      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0 * scaler.widthScaleFactor),
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
        padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
        child: ElevatedButton(
          onPressed: () {/* Submit form logic */},
          style: ElevatedButton.styleFrom(
            minimumSize: Size( width , 50), // Ensure the button is wide enough
            backgroundColor: MyTheme.bottomElevatedGreen, // Set the background color
            // You can also set the foreground (text) color, if needed
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder( // Set the button's shape
              borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor), // Rounded corners
            ),
          ),
          child: Text(
            'Submit',
            style: TextStyle(
              fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}