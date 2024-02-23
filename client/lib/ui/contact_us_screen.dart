import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate padding dynamically based on screen size
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = screenHeight * 0.01;
    double largePadding = screenHeight * 0.04;
    double smallPadding = screenHeight * 0.015;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support Us',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
                'Contact us and we will try our best to resolve your issue.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: largePadding),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: smallPadding),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'example@gmail.com',
                  filled: true, // Enable the fill color
                  fillColor: Colors.grey[200], // Fill color
                  border: OutlineInputBorder( // Outline border
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none, // No border side
                  ),
                  // Optional: Customize the appearance when the field is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  // Optional: Customize the appearance when the field is enabled but not focused
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
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
                SizedBox(height: largePadding),
              const Text(
                'Message',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
                SizedBox(height: smallPadding),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
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
        padding: EdgeInsets.all(horizontalPadding),
        child: ElevatedButton(
          onPressed: () {/* Submit form logic */},
          style: ElevatedButton.styleFrom(
            minimumSize: Size(screenWidth, 50), // Ensure the button is wide enough
          ),
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
