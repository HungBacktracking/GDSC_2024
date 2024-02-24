import 'package:client/ui/upload_image.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';
import '../utils/themes.dart';

class UpdateCertificateScreen extends StatelessWidget{
  final List<String> certificatesTitles;
  final List<String> certificatesImageUrls;

  const UpdateCertificateScreen({
    Key? key,
    required this.certificatesTitles,
    required this.certificatesImageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Certificate',
          style: TextStyle(
            fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size : 25.0 * scaler.widthScaleFactor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 8.0 * scaler.widthScaleFactor, right: 16.0 * scaler.widthScaleFactor, left: 16.0 * scaler.widthScaleFactor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Space before the certificates
                  SizedBox(height: 25 * scaler.widthScaleFactor),
                  // Certificates Block
                  CertificatesBlock(
                    certificatesTitles: certificatesTitles,
                    certificatesImgageUrls: certificatesImageUrls,
                  ),
                  // Space after the certificates
                  SizedBox(height: 25 * scaler.widthScaleFactor),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageUploadScreen(),
                  ),
                );
              },
              child: Text(
                'Upload Certificate',
                style: TextStyle(
                  fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CertificatesBlock extends StatelessWidget{
  final List<String> certificatesTitles;
  final List<String> certificatesImgageUrls;

  const CertificatesBlock({
    Key? key,
    required this.certificatesTitles,
    required this.certificatesImgageUrls,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 20.0 * scaler.widthScaleFactor, top: 5.0 * scaler.widthScaleFactor,
            bottom: 5.0 * scaler.widthScaleFactor, right: 20.0 * scaler.widthScaleFactor),
        child: certificatesTitles.isNotEmpty?
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Ensure title is left-aligned
                children: certificatesTitles
                    .asMap()
                    .entries
                    .map((entry) {
                      int index = entry.key;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    certificatesTitles[index],
                                    style: TextStyle(
                                      fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5 * scaler.widthScaleFactor),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1 * scaler.widthScaleFactor,
                                      ),
                                    ),
                                    child: Image.network(
                                      certificatesImgageUrls[index],
                                      fit: BoxFit.cover, // Cover the width without distorting aspect ratio
                                    ),
                                  ),
                                  SizedBox(height: 15 * scaler.widthScaleFactor), // Adjusted for consistent spacing
                                ],
                                ),
                            ),
                            SizedBox(width: 20 * scaler.widthScaleFactor),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      //navigate to upload certificate screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context)
                                          => ImageUploadScreen(
                                            oldTitle: certificatesTitles[index],
                                            oldImageUrl: certificatesImgageUrls[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _showRemoveConfirmationDialog(context);
                                      },
                                    child: Text(
                                      "Remove",
                                      style: TextStyle(
                                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                ),
                              ],
                            )
                          ],
                        );
                        }).toList(),
                    ),
            )
              : Text(
                "There is no certificate to show.",
                style: TextStyle(
                  fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor ,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Removal'),
          content: const Text('Are you sure you want to remove this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform the removal operation
                _removeItem();
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  void _removeItem() {
    // Implement your item removal logic here
    print('Item removed');
  }
}