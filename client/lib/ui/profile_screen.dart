import 'package:client/ui/greeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/themes.dart';

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
      appBar: AppBar(
        title: const Text(
        'Profile',
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0, bottom: 100),
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
                            width: 1,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(avatarUrl), // Use NetworkImage
                          backgroundColor: Colors.white,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    )
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //General Information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'General Information',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              ContentContainer(titles: titles, contents: contents),

            //Skills
            const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Skills',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              ContentContainer(titles: skills, contents: skillContents),

              const SizedBox(height: 25),
              //Activity
              const Text(
                'Your Activity',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600
                ),
              ),

              const SizedBox(height: 8),
              const FunctionTag(
                  icon: Icons.history,
                  title: "History",
                  onPressed: null
              ),

              //Certificates
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Certificates',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      //handle tap
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CertificatesBlock(
                certificatesTitles: certificatesTitles,
                certificatesImgageUrls: certificatesImageUrls,
              ),

              //Support and Legal
              const SizedBox(height: 25),
              const Text(
                'Support & Legal',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(height: 8),
              const FunctionTag(
                  icon: Icons.privacy_tip,
                  title: "Privacy Policy",
                  onPressed: null
              ),
              const SizedBox(height: 8),
              const FunctionTag(
                  icon: Icons.call,
                  title: "Contact us",
                  onPressed: null
              ),

              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
                      await _firebaseAuth.signOut();

                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) {
                              return const GreetingScreen();
                            }
                        ),
                            (Route<dynamic> route) => false,
                      );
                      
                    },
                    child: const Text(
                      'Log out',
                      style: TextStyle(
                        fontSize: 22.0,
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
    return Container(
      decoration: BoxDecoration(
        color: MyTheme.lightRedBackGround,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 20.0, top: 5.0, bottom: 5.0, right: 20.0),
        child: certificatesTitles.isEmpty
            ? const Text(
          "No data",
          style: TextStyle(
            fontSize: 18.0,
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
                    width: double.infinity, // Make image fill max width
                    fit: BoxFit.cover, // Cover the width without distorting aspect ratio
                  ),
                ),
                const SizedBox(height: 15), // Adjusted for consistent spacing
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