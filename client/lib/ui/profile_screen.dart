import 'package:client/ui/greeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/scaler.dart';
import '../utils/themes.dart';
import '../view_model/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget{
  final String avatarUrl;
  final String userName;

  const ProfileScreen({
    Key? key,
    required this.avatarUrl,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    final List<String> titles = ["Nhom mau", "Tuoi", "Tien su benh"];
    final List<String> contents = ["O", "40", "Khong co"];

    final List<String> skills = ["Burn", "Choking", "Bite", "Electric Shock", "Eye Injury"];
    final List<String> skillContents = ["Medium", "Expert", "Normal", "Medium", "Medium"];
    
    final List<String> certificatesTitles = ["CPR", "Bite", "Electric Shock"];
    final List<String> certificatesImageUrls = [
      "https://blogs.bournemouth.ac.uk/research/files/2014/07/Certificate-of-Merit2.jpg",
      "https://blogs.bournemouth.ac.uk/research/files/2014/07/Certificate-of-Merit2.jpg",
      "https://blogs.bournemouth.ac.uk/research/files/2014/07/Certificate-of-Merit2.jpg",
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.grey[100],
        title: Text(
        'Profile',
          style: TextStyle(
            fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 8.0 * scaler.widthScaleFactor, right: 16.0 * scaler.widthScaleFactor, left: 16.0 * scaler.widthScaleFactor, bottom: 100 * scaler.widthScaleFactor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1 * scaler.widthScaleFactor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5 * scaler.widthScaleFactor,
                              spreadRadius: 1 * scaler.widthScaleFactor,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 70 * scaler.widthScaleFactor,
                          backgroundImage: NetworkImage(avatarUrl), // Use NetworkImage
                          backgroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8 * scaler.widthScaleFactor),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.bold
                      ),
                    )
                    ],
                  ),
                ],
              ),

              SizedBox(height: 25 * scaler.widthScaleFactor),

              //General Information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'General Information',
                    style: TextStyle(
                      fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8 * scaler.widthScaleFactor),
              ContentContainer(titles: titles, contents: contents),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              //Skills
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Skills',
                    style: TextStyle(
                        fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 8 * scaler.widthScaleFactor),
              ContentContainer(titles: skills, contents: skillContents),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              //Activity
              Text(
                'Your Activity',
                style: TextStyle(
                    fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.w600
                ),
              ),

              SizedBox(height: 8 * scaler.widthScaleFactor),
              const FunctionTag(
                  icon: Icons.history,
                  title: "History",
                  onPressed: null
              ),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              //Certificates
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Certificates',
                    style: TextStyle(
                        fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8 * scaler.widthScaleFactor),
              CertificatesBlock(
                certificatesTitles: certificatesTitles,
                certificatesImgageUrls: certificatesImageUrls,
              ),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              SizedBox(height: 10 * scaler.widthScaleFactor),

              //Support and Legal
              Text(
                'Support & Legal',
                style: TextStyle(
                    fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 8 * scaler.widthScaleFactor),
              const FunctionTag(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onPressed: null
              ),
              SizedBox(height: 8 * scaler.widthScaleFactor),
              const FunctionTag(
                  icon: Icons.call,
                  title: "Contact us",
                  onPressed: null
              ),

              SizedBox(height: 10 * scaler.widthScaleFactor),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                      await authViewModel.signOut(context);
                    },
                    child: Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 22.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
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
    Scaler scaler = Scaler();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
      ),
      child: Padding(
        padding:  EdgeInsets.only(
            left: 20.0 * scaler.widthScaleFactor, top: 5.0 * scaler.widthScaleFactor,
            bottom: 5.0 * scaler.widthScaleFactor, right: 20.0 * scaler.widthScaleFactor),
        child: certificatesTitles.isEmpty
            ? Text(
          "No certificate update yet!",
          style: TextStyle(
            fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure title is left-aligned
          children: certificatesTitles
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            return Column(
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
                    width: double.infinity, // Make image fill max width
                    fit: BoxFit.cover, // Cover the width without distorting aspect ratio
                  ),
                ),
                SizedBox(height: 15 * scaler.widthScaleFactor), // Adjusted for consistent spacing
              ],
            );
          }).toList(),
        ),
      ),
    );
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
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10* scaler.widthScaleFactor),
      ),
      child: Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0 * scaler.widthScaleFactor),
          child: InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 20.0 * scaler.widthScaleFactor, top: 5.0 * scaler.widthScaleFactor,
                    bottom: 5.0 * scaler.widthScaleFactor, right: 20.0 * scaler.widthScaleFactor),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 30* scaler.widthScaleFactor,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10 * scaler.widthScaleFactor),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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
      Scaler().init(context);
      Scaler scaler = Scaler();
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
        ),
        child: Expanded(
         child: Padding(
            padding: EdgeInsets.only(left: 20.0 * scaler.widthScaleFactor, top: 5.0 * scaler.widthScaleFactor,
                bottom: 5.0 * scaler.widthScaleFactor, right: 20.0 * scaler.widthScaleFactor),
            child:
            contents.isEmpty ?
            Text(
              "No data",
              style: TextStyle(
                fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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
                        style: TextStyle(
                          fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                        Text(
                          contents[index],
                          style: TextStyle(
                              fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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