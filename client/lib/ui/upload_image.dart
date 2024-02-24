import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/spacer.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';

class ImageUploadScreen extends StatefulWidget {
  final String? oldTitle;
  final String? oldImageUrl;

  const ImageUploadScreen({
    super.key,
    this.oldTitle,
    this.oldImageUrl,
  }
      );

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  late TextEditingController _titleController;
  File? _image;
  late String _oldImageUrl;

  @override
  void dispose() {
    // Dispose the controller when the widget is removed from the widget tree
    _titleController.dispose();
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _oldImageUrl = widget.oldImageUrl ?? '';
    _titleController = TextEditingController(text: widget.oldTitle);
  }

  void saveChanges() {
    // Implement your save logic here
    // For example, upload the image and title to your server
    print('Title: ${_titleController.text}');
    if (_image != null) {
      print('Image Path: ${_image!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate padding dynamically based on screen size
    double horizontalMargin = MySpacer.normalHorizontalMargin(context);

    // Get the text scale factor
    TextScaler textScaler = MyStyles.textScaler(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
              _titleController.text.isEmpty ? 'Upload Certificate' : 'Update Certificate',
              style: MyStyles.largeBoldTextStyle(),
            textScaler: textScaler,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: Column(
        children: <Widget>[
          imageContainer(_oldImageUrl),
          ElevatedButton(
            onPressed: getImage,
            child: Text(
                'Upload Image',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'First Aid Type',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(horizontalMargin),
            child: ElevatedButton(
              onPressed: saveChanges,
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
                  'Save Changes',
                  style: MyStyles.normalBoldTextStyle(color: Colors.white),
                  textScaler: textScaler,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageContainer(String? oldImageUrl) {

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth - 32.0; // Subtracting 16.0 margin from both sides
    double containerHeight = (containerWidth / 16) * 9; // Maintaining 16:9 aspect ratio

    double horizontalMargin = MySpacer.normalHorizontalMargin(context);

    return Padding(
      padding: EdgeInsets.all(horizontalMargin), // This adds the margin around the container
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(MyStyles.cornerRadius),
          color: Colors.grey[200],
        ),
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MyStyles.cornerRadius), // Match the container's borderRadius
            child: (){
              if (_image != null) {
                return Image.file(
                  _image!,
                  width: containerWidth,
                  height: containerHeight,
                  fit: BoxFit.contain,
                );
              } else if (oldImageUrl != '') {
                return Image.network(
                  oldImageUrl!,
                  width: containerWidth,
                  height: containerHeight,
                  fit: BoxFit.contain,
                );
              } else {
                return Center(
                  child: Text(
                    'No image selected',
                    style: MyStyles.largeTextStyle(),
                    textScaler: MyStyles.textScaler(context),
                  ),
                );
              }
            } (),
          ),
        ),
      ),
    );
  }
}
