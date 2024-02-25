// A screen that allows users to take a picture using a given camera.
import 'dart:io';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/scaler.dart';

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
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.file(File(imagePath), fit: BoxFit.cover),
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
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red[600],
                        padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
                      ),
                      child: Text(
                        "Find help",
                        style: TextStyle(
                            fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            fontWeight: FontWeight.bold),
                      ),
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