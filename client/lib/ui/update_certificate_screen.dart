import 'package:client/ui/upload_image.dart';
import 'package:flutter/material.dart';

import '../utils/spacer.dart';
import '../utils/styles.dart';
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
    // Get screen size
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate padding dynamically based on screen size
    double horizontalMargin = MySpacer.normalHorizontalMargin(context);
    double verticalMargin = MySpacer.normalVerticalMargin(context);
    double largeVerticalSpacer = MySpacer.largeHeight(context);
    // Get the text scale factor
    TextScaler textScaler = MyStyles.textScaler(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Certificate',
          style: MyStyles.largeBoldTextStyle(),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
              padding: EdgeInsets.only(top: verticalMargin, right: horizontalMargin, left: horizontalMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Space before the certificates
                  SizedBox(height: largeVerticalSpacer),
                  // Certificates Block
                  CertificatesBlock(
                    certificatesTitles: certificatesTitles,
                    certificatesImgageUrls: certificatesImageUrls,
                  ),
                  // Space after the certificates
                 SizedBox(height: largeVerticalSpacer),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(horizontalMargin),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageUploadScreen(),
                  ),
                );
              },
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
                'Upload Certificate',
                style: MyStyles.largeBoldTextStyle(color: Colors.white),
                textScaler: textScaler,
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
    // Calculate padding dynamically based on screen size
    double horizontalMargin = MySpacer.smallHorizontalMargin(context);
    double verticalMargin = MySpacer.largeVerticalMargin(context);
    double largeVerticalSpacer = MySpacer.largeHeight(context);
    double smallVerticalSpacer = MySpacer.smallHeight(context);

    // Get the text scale factor
    TextScaler textScaler = MyStyles.textScaler(context);

    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(MyStyles.cornerRadius),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: verticalMargin, top: horizontalMargin, bottom: 5.0, right: 20.0),
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
                                    style: MyStyles.normalBoldTextStyle(),
                                    textScaler: textScaler,
                                  ),
                                  SizedBox(height: smallVerticalSpacer),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Image.network(
                                      certificatesImgageUrls[index],
                                      fit: BoxFit.cover, // Cover the width without distorting aspect ratio
                                    ),
                                  ),
                                  SizedBox(height: largeVerticalSpacer), // Adjusted for consistent spacing
                                ],
                                ),
                            ),
                            SizedBox(width: largeVerticalSpacer),
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
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyTheme.submitBtnColor, // Set the background color
                                      // You can also set the foreground (text) color, if needed
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder( // Set the button's shape
                                        borderRadius: BorderRadius.circular(MyStyles.cornerRadius), // Rounded corners
                                      ),
                                    ),
                                    child: Text(
                                      "Update",
                                      style: MyStyles.largeBoldTextStyle(color: Colors.white),
                                      textScaler: textScaler,
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _showRemoveConfirmationDialog(context);
                                      },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyTheme.submitBtnColor, // Set the background color
                                    // You can also set the foreground (text) color, if needed
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder( // Set the button's shape
                                      borderRadius: BorderRadius.circular(MyStyles.cornerRadius), // Rounded corners
                                    ),
                                  ),
                                    child: Text(
                                        "Remove",
                                        style: MyStyles.largeBoldTextStyle(color: Colors.white),
                                        textScaler: textScaler,
                                      ),
                                    )
                              ],
                            )
                          ],
                        );
                        }).toList(),
                    ),
            )
              : const Text(
                "There is no certificate to show.",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
      ),
    );
  }

  void _showRemoveConfirmationDialog(BuildContext context) {
    TextScaler textScaler = MyStyles.textScaler(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              'Confirm Removal',
            style: MyStyles.largeBoldTextStyle(),
          ),
          content: Text(
              'Are you sure you want to remove this item?',
              style: MyStyles.normalTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text(
                  'Cancel',
                style: MyStyles.normalBoldTextStyle(),
                textScaler: textScaler,
              ),
            ),
            TextButton(
              onPressed: () {
                // Perform the removal operation
                _removeItem();
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text(
                  'Remove',
                  style: MyStyles.normalBoldTextStyle(),
                  textScaler: textScaler,
              )
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