import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/scaler.dart';
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
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
              _titleController.text.isEmpty ? 'Upload Certificate' : 'Update Certificate',
              style: TextStyle(
                fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, size: 25 * scaler.widthScaleFactor),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: Column(
        children: <Widget>[
          imageContainer(_oldImageUrl, context),
          ElevatedButton(
            onPressed: getImage,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(0, 50 * scaler.widthScaleFactor),
              backgroundColor: MyTheme.orange,
            ),
            child: Text(
                'Upload Image',
                style: TextStyle(
                  fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
            child: TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'First Aid Type',
                labelStyle: TextStyle(
                  fontSize: 16.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
            child: ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50 * scaler.widthScaleFactor),
                backgroundColor: MyTheme.bottomElevatedGreen,
              ),
              child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageContainer(String? oldImageUrl, BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth - 32.0; // Subtracting 16.0 margin from both sides
    double containerHeight = (containerWidth / 16) * 9; // Maintaining 16:9 aspect ratio

    return Padding(
      padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor), // This adds the margin around the container
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1 * scaler.widthScaleFactor,
          ),
          borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
          color: Colors.grey[200],
        ),
        child: Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor), // Match the container's borderRadius
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
                      'No image selected.',
                      style: TextStyle(
                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
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

