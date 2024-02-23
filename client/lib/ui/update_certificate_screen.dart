import 'package:client/ui/upload_image.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Certificate',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
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
              padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Space before the certificates
                  const SizedBox(height: 25),
                  // Certificates Block
                  CertificatesBlock(
                    certificatesTitles: certificatesTitles,
                    certificatesImgageUrls: certificatesImageUrls,
                  ),
                  // Space after the certificates
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageUploadScreen(),
                  ),
                );
              },
              child: const Text(
                'Upload Certificate',
                style: TextStyle(
                  fontSize: 20.0,
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
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
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
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
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
                                  const SizedBox(height: 15), // Adjusted for consistent spacing
                                ],
                                ),
                            ),
                            const SizedBox(width: 20),
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
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      _showRemoveConfirmationDialog(context);
                                      },
                                    child: const Text(
                                      "Remove",
                                      style: TextStyle(
                                        fontSize: 20.0,
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

class FunctionTag extends StatelessWidget{
  final IconData icon;
  final String title;
  final VoidCallback? onPressed;

  const FunctionTag({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                color: MyTheme.lightRedBackGround,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class ContentContainer extends StatelessWidget {
  final List<String> titles;
  final List<String> contents;

  const ContentContainer({
    Key? key,
    required this.titles,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
            child:
            contents.isEmpty ?
            const Text(
              "No data",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ) :
            Column(
                children:
                titles.asMap().entries.map((entry) {
                  int index = entry.key;
                  return
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${titles[index]} : ",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          contents[index],
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 2,
                        )
                      ],
                    );
                }).toList()
            ),
          )
      ),

    );
  }
}