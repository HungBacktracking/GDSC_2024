import 'package:flutter/material.dart';

import '../models/quiz_category_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            height: 200, // Adjust the size accordingly
          ),
          const SizedBox(height: 40),
          Text(
            'Complete',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Padding( // Wrap the Row in Padding
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded( // Expanded widget
                  child: _buildInfoCard('Time', time, context),
                ),
                SizedBox(width: 16), // Spacing between cards
                Expanded( // Expanded widget
                  child: _buildInfoCard('Correct', '$correctQuestions/$totalQuestions', context),
                ),
              ],
            ),
          ),
          Spacer(), // Pushes the button to the bottom
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
                onPrimary: Colors.white, // foreground
                minimumSize: Size(double.infinity, 50), // Set the button to take full width
              ),
              onPressed: () {
                final List<QuizCategoryModel> challengeYouCategories = [
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                ];

                final List<QuizCategoryModel> topicsCategories = [
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                  QuizCategoryModel(title: 'CPR for Adult', tag: 'CPR', tagColor: Colors.red),
                  QuizCategoryModel(title: 'Electric Shock', tag: 'First Aid', tagColor: Colors.blue),
                ];

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LearningFirstAidScreen(
                      userName: 'Rohan', // Pass the user name here
                      avatarUrl: 'https://static-images.vnncdn.net/files/publish/2022/6/28/lannha01-1073.jpg', // Pass the user avatar URL here
                      challengeYouCategories: challengeYouCategories,
                      topicsCategories: topicsCategories,
                    ),
                  ),
                );
              },
              child: Text('OKAY'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, BuildContext context) {
    Color color = title == 'Time' ? Colors.blue : Colors.green;
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    // Calculate icon size as a proportion of screen width but with a reasonable max size
    double iconSize = screenWidth * 0.1; // for example, 10% of screen width
    iconSize = iconSize > 60.0 ? 60.0 : iconSize; // max size to 60, for example

    return Card(
      elevation: 4.0,
      child: Container(
        width: double.infinity, // Ensure the container fills the width of the Expanded widget
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center along main axis
            crossAxisAlignment: CrossAxisAlignment.center, // Center along cross axis
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min, // Use the minimum space for the row
                children: [
                  Icon(
                    title == 'Time' ? Icons.access_time : Icons.check_circle_outline,
                    color: color,
                    size: iconSize, // Set the icon size
                  ),
                  SizedBox(width: 8), // Spacing between icon and title
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: iconSize * 0.5),
            ],
          ),
        ),
      ),
    );
  }

}
