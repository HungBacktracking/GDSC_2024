import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  final String appBarTitle;

  const ImageUploadScreen({Key? key, required this.appBarTitle}) : super(key: key);
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  late String _appBarTitle;
  File? _image;
  final TextEditingController _titleController = TextEditingController();

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
    _appBarTitle = widget.appBarTitle;
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
    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Update $_appBarTitle',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          )
      ),
      body: Column(
        children: <Widget>[
          imageContainer(),
          ElevatedButton(
            onPressed: getImage,
            child: const Text('Upload Image'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Image Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: saveChanges,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                ),
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageContainer() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth - 32.0; // Subtracting 16.0 margin from both sides
    double containerHeight = (containerWidth / 16) * 9; // Maintaining 16:9 aspect ratio

    return Padding(
      padding: const EdgeInsets.all(16.0), // This adds the margin around the container
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10), // Match the container's borderRadius
          child: _image == null
              ? const Center(child: Text('No image selected.')) // Center align the text
              : Image.file(
            _image!,
            fit: BoxFit.cover, // Make sure the image covers the container correctly
          ),
        ),
      ),
    );
  }
}

