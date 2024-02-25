import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

import '../models/quiz_category_model.dart';
import '../utils/scaler.dart';
import 'learning_firstaid_screen.dart';

class CompleteScreen extends StatelessWidget {
  final String imageUrl;
  final String time;
  final int correctQuestions;
  final int totalQuestions;
  final String title;

  CompleteScreen({
    required this.imageUrl,
    required this.time,
    required this.correctQuestions,
    required this.totalQuestions,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changes here
        children: <Widget>[
          Image.network(
            imageUrl,
            height: 200 * scaler.widthScaleFactor, // Adjust the size accordingly
          ),
          SizedBox(height: 40 * scaler.widthScaleFactor),
          Text(
            'Complete',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5 * scaler.widthScaleFactor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Image.asset("assets/icons/ic_firework.png", height: 50 * scaler.widthScaleFactor, width: 50 * scaler.widthScaleFactor),
              SizedBox(width: 8 * scaler.widthScaleFactor),
              Image.asset("assets/icons/ic_firework.png", height: 50 * scaler.widthScaleFactor, width: 50 * scaler.widthScaleFactor),
              SizedBox(width: 8 * scaler.widthScaleFactor),
              Image.asset("assets/icons/ic_firework.png", height: 50 * scaler.widthScaleFactor, width: 50 * scaler.widthScaleFactor),
              SizedBox(width: 8 * scaler.widthScaleFactor),
              ],
          ),
          Padding(
            // Wrap the Row in Padding
            padding: EdgeInsets.symmetric(horizontal: 16.0 * scaler.widthScaleFactor, vertical: 40.0 * scaler.widthScaleFactor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  // Expanded widget
                  child: _buildInfoCard('Time', time, context),
                ),
                SizedBox(width: 16 * scaler.widthScaleFactor), // Spacing between cards
                Expanded(
                  // Expanded widget
                  child: _buildInfoCard(
                      'Correct', '$correctQuestions/$totalQuestions', context),
                ),
              ],
            ),
          ),
          Spacer(), // Pushes the button to the bottom
          Padding(
            padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                //corner
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor),
                ),
                minimumSize: Size(double.infinity, 50 * scaler.widthScaleFactor), // Set the button to take full width
                backgroundColor: MyTheme.bottomElevatedGreen,
              ),
              onPressed: () {
                final List<QuizCategoryModel> challengeYouCategories = [
                  QuizCategoryModel(title: 'Burn', tag: 'burn', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'electric shock', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.orange),
                  QuizCategoryModel(title: 'CPR for Children', tag: 'CPR', tagColor: Colors.greenAccent),
                ];

                final List<QuizCategoryModel> topicsCategories = [
                  QuizCategoryModel(title: 'Burn', tag: 'burn', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'electric shock', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.orange),
                  QuizCategoryModel(title: 'CPR for Children', tag: 'CPR', tagColor: Colors.greenAccent),
                  QuizCategoryModel(title: 'Head Bleeding', tag: 'bleeding', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Poisons', tag: 'poisons', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'Fracture', tag: 'fracture', tagColor: Colors.orange),
                  QuizCategoryModel(title: 'Snake Bite', tag: 'bite', tagColor: Colors.greenAccent),
                  QuizCategoryModel(title: 'Choking', tag: 'choking', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Drug Overdose', tag: 'drug overdose', tagColor: Colors.blue),
                ];

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LearningFirstAidScreen(
                      userName: 'Rohan', // Pass the user name here
                      avatarUrl:
                          'https://static-images.vnncdn.net/files/publish/2022/6/28/lannha01-1073.jpg', // Pass the user avatar URL here
                      challengeYouCategories: challengeYouCategories,
                      topicsCategories: topicsCategories,
                    ),
                  ),
                );
              },

              child: Text(
                  'OKAY',
                  style: TextStyle(
                    fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
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

  Widget _buildInfoCard(String title, String value, BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    Color color = title == 'Time' ? Colors.blue : Colors.green;
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate icon size as a proportion of screen width but with a reasonable max size
    double iconSize = screenWidth * 0.1 * scaler.widthScaleFactor; // for example, 10% of screen width
    iconSize = iconSize > 60.0* scaler.widthScaleFactor ? 60.0* scaler.widthScaleFactor : iconSize; // max size to 60, for example

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300]?.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8.0 * scaler.widthScaleFactor),
      ),
      width: double.infinity, // Ensure the container fills the width of the Expanded widget
      child: Padding(
        padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center along main axis
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center along cross axis
          children: <Widget>[
            Row(
              mainAxisSize:
                  MainAxisSize.min, // Use the minimum space for the row
              children: [
                Icon(
                  title == 'Time'
                      ? Icons.access_time
                      : Icons.check_circle_outline,
                  color: color,
                  size: iconSize, // Set the icon size
                ),
                SizedBox(width: 8 * scaler.widthScaleFactor), // Spacing between icon and title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 26.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8 * scaler.widthScaleFactor),
            Text(
              value,
              style: TextStyle(
                fontSize: 30.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: iconSize * 0.5),
          ],
        ),
      ),
    );
  }
}
