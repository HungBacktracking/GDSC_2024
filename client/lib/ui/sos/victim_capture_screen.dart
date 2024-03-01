// A screen that allows users to take a picture using a given camera.
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:client/ui/sos/helper_accept_sos_screen.dart';
import 'package:client/utils/helper.dart';
import 'package:http/http.dart' as http;

import 'package:camera/camera.dart';
import 'package:client/models/address_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../utils/scaler.dart';
import '../../widgets/custom_filled_button.dart';
import '../sos_screen.dart';

class VictimCaptureScreen extends StatefulWidget {
  const VictimCaptureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;


  @override
  VictimCaptureScreenState createState() => VictimCaptureScreenState();
}

class VictimCaptureScreenState extends State<VictimCaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    // Create and initialize the controller.
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize().then((_) {
      // Ensure that the camera is initialized.
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          // Widget to display while waiting for the future to complete
          Widget content = const Center(child: CircularProgressIndicator());

          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            content = CameraPreview(_controller);
          }

          return Stack(
            children: <Widget>[
              // Full-screen camera preview
              Positioned.fill(child: content),
              // Centered floating action button
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () async {
                      try {
                        await _initializeControllerFuture;
                        final image = await _controller.takePicture();

                        if (!context.mounted) return;

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                              DisplayPictureScreen(
                                imagePath: image.path,
                              ),
                          ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  bool _isProcessing = false;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }

  Future<String> uploadImage(String imagePath) async {
    final _firebaseStorage = FirebaseStorage.instance;

    var file = File(imagePath);
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.png';

    //Upload to Firebase
    var snapshot = await _firebaseStorage.ref().child(fileName).putFile(file);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }


  Future<String> sendHelpInfoToServer(String uid, AddressModel location, String image) async {
    Map<String, dynamic> data = {
      'uid': uid,
      'location': location.toJson(),
      'image_link': image,
    };
    print("Data is: $data");
    String bodyJson = json.encode(data);

    try {
      final response = await http.post(
        Uri.parse('https://go-echo-server.onrender.com/sos/create_room'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: bodyJson,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        getSuccessSnackBar("Send help successfully!");
        Map<String, dynamic> responseData = json.decode(response.body);
        String roomId = responseData['roomID'];
        return roomId;
      } else {
        getErrorSnackBarNew("Failed to create data!");
        return '';
      }
    } catch (e) {
      getErrorSnackBar("Failed to create data", e);
      return '';
    }

  }

  Future<void> handleFindHelp(String imagePath) async {
    setState(() {
      _isProcessing = true;
    });

    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    String userId = _firebaseAuth.currentUser!.uid;

    Position? currentPosition;
    currentPosition = await _getCurrentLocation();
    var imageUri = await uploadImage(imagePath);
    AddressModel location = AddressModel(coordinates: GeoPoint(currentPosition.latitude, currentPosition.longitude));
    print(imageUri);
    String roomId = await sendHelpInfoToServer(userId, location, imageUri);
    print("Roomm: $roomId");

    setState(() {
      _isProcessing = false;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HelperSOSScreen()
            // SOSScreen(
            //   roomId: roomId,
            // ),
      ),
  );
  }

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(File(widget.imagePath), fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20 * scaler.widthScaleFactor),
                      topRight: Radius.circular(20 * scaler.widthScaleFactor))),
              padding: EdgeInsets.all(16 * scaler.widthScaleFactor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you in an emergency?',
                    style: TextStyle(
                      fontSize: 26 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 16 * scaler.widthScaleFactor),
                  Text(
                    'Help will arrive shortly',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18 * scaler.widthScaleFactor/ scaler.textScaleFactor,
                    ),
                  ),
                  SizedBox(height: 25 * scaler.widthScaleFactor),
                  SizedBox(
                    width: double.infinity,
                    child: CustomFilledButton(
                      label: "Find help",
                      isLoading: _isProcessing,
                      onPressed: _isProcessing ? () {} : () {
                        handleFindHelp(widget.imagePath);
                      },
                    ),
                  ),
                  SizedBox(height: 16 * scaler.widthScaleFactor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}