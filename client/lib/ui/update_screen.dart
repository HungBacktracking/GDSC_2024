import 'package:flutter/material.dart';

import '../utils/spacer.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';

class UpdateInfoScreen extends StatefulWidget {
  final List<String> titles;
  final List<String> contents;
  final String appBarTitle;

  const UpdateInfoScreen({
    Key? key,
    required this.appBarTitle,
    required this.titles,
    required this.contents,
  }) : super(key: key);

  @override
  _UpdateInfoScreenState createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _appBarTitle;
  // Use a Map to track the updated values
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();

    _appBarTitle = widget.appBarTitle;
    // Initialize the text editing controllers with the old data
    for (int i = 0; i < widget.titles.length; i++) {
      controllers[widget.titles[i]] = TextEditingController(text: widget.contents[i]);
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here, you would update your backend or local storage with the new values
      // For demonstration, we'll just print the updated values to the console
      // controllers.forEach((title, controller) {
      //   print('$title: ${controller.text}');
      // });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Information Updated!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate padding dynamically based on screen size
    double horizontalMargin = MySpacer.normalHorizontalMargin(context);
    double largeVerticalHeight = MySpacer.largeHeight(context);

    // Get the text scale factor
    TextScaler textScaler = MyStyles.textScaler(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Update $_appBarTitle',
            style: MyStyles.largeBoldTextStyle(),
        ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: Padding(
        padding: EdgeInsets.all(horizontalMargin),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (var title in widget.titles)
                  Column(
                    children: [
                      TextFormField(
                        controller: controllers[title],
                        decoration: InputDecoration(
                            labelText: title,
                            labelStyle: MyStyles.largeBoldTextStyle(),
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
                          // Simple validation: ensure the field is not empty
                          if (value == null || value.isEmpty) {
                            return 'Please enter your $title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: largeVerticalHeight),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(horizontalMargin),
        child: ElevatedButton(
          onPressed: _submitForm,
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
            'Update Information',
            style: MyStyles.largeBoldTextStyle(color: Colors.white),
            textScaler: textScaler,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}
