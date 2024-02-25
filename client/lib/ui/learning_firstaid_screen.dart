import 'package:client/models/quiz_category_model.dart';
import 'package:client/models/quiz_model.dart';
import 'package:client/ui/quiz_game_screen.dart';
import 'package:client/utils/themes.dart';
import 'package:client/view_model/quiz_viewmodel.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';
import 'home_screen.dart';

class LearningFirstAidScreen extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final List<QuizCategoryModel> challengeYouCategories;
  final List<QuizCategoryModel> topicsCategories;

  LearningFirstAidScreen({
    required this.userName,
    required this.avatarUrl,
    required this.challengeYouCategories,
    required this.topicsCategories,
  });

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 25.0 * scaler.widthScaleFactor),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        title: Text(
            'LEARNING FIRST AID',
            style: TextStyle(
              fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
              color: MyTheme.blueBorder,
              fontWeight: FontWeight.w500,
            ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 16.0 * scaler.widthScaleFactor, right: 16.0 * scaler.widthScaleFactor, top: 4.0 * scaler.widthScaleFactor, bottom: 8.0 * scaler.widthScaleFactor),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: 35 * scaler.widthScaleFactor / scaler.textScaleFactor,
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'Hi '),
                            TextSpan(text: 'Rohan'),
                            TextSpan(text: ','),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(avatarUrl), // Use the passed avatar URL
                      radius: 20 * scaler.widthScaleFactor, // Adjust the size as needed
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0 * scaler.widthScaleFactor),
                  child: Text(
                    'What do you want to learn today?',
                    style: TextStyle(
                      fontSize: 20 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      color: Colors.black,
                    )
                  ),
                ),
                SizedBox(height: 20 * scaler.widthScaleFactor),
                Container(
                  height: 60.0 * scaler.widthScaleFactor,
                  width: double.infinity,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0 * scaler.widthScaleFactor),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0 * scaler.widthScaleFactor),
                    ),
                    style: TextStyle(
                      fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor, // Specify the font size of the text
                    ),
                  ),
                ),

                //challenge you
                Padding(
                  padding: EdgeInsets.only(top: 25.0 * scaler.widthScaleFactor, bottom: 8.0 * scaler.widthScaleFactor),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/ic_challenge_you.png', width: 38 * scaler.widthScaleFactor, height: 38 * scaler.widthScaleFactor), // Adjust the size as needed
                      SizedBox(width: 8 * scaler.widthScaleFactor),
                      Text(
                        'Challenge You',
                        style: TextStyle(
                            fontSize: 26 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            fontWeight: FontWeight.bold,
                            color: MyTheme.challengeYouBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                CategoryGrid(challengeYouCategories),
                Padding(
                  padding: EdgeInsets.only(top: 25.0 * scaler.widthScaleFactor, bottom: 8.0 * scaler.widthScaleFactor),
                  child: Row(
                    children: [
                      Image.asset('assets/icons/ic_topic.png', width: 38 * scaler.widthScaleFactor, height: 38 * scaler.widthScaleFactor), // Adjust the size as needed
                      SizedBox(width: 8 * scaler.widthScaleFactor),
                      Text(
                        'Topics',
                        style: TextStyle(
                          fontSize: 26 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.challengeYouBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                CategoryGrid(topicsCategories),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final List<QuizCategoryModel> categories;

  CategoryGrid(this.categories);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();

    // Calculate the aspect ratio based on desired item width and height
    double itemWidth = 170 * scaler.widthScaleFactor; // Desired item width
    double itemHeight = 90 * scaler.widthScaleFactor; // Desired item height
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double crossAxisSpacing = 16 * scaler.widthScaleFactor;  // Adjust as needed
    double mainAxisSpacing = 16 * scaler.widthScaleFactor; // Adjust as needed
    int crossAxisCount = 2; // Number of items per row
    double totalHorizontalPadding = 32 * scaler.widthScaleFactor; // Adjust as needed
    double totalCrossAxisSpacing = (crossAxisCount - 1) * crossAxisSpacing * scaler.widthScaleFactor;

    // Calculate the aspect ratio of each item
    double childAspectRatio = (itemWidth / itemHeight) *
        ((screenWidth - totalHorizontalPadding - totalCrossAxisSpacing) /
            (crossAxisCount * itemWidth));

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: categories.length, // Replace with your actual item count
      itemBuilder: (context, index) {
        // Replace with your category data
        return QuizCategoryItem(
          title: categories[index].title,
          tag: categories[index].tag,
          tagColor: categories[index].tagColor, // Pass the tag color
          onTap: () {
            QuizViewModel quizViewModel = QuizViewModel();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(
                  title: "Burn",
                  quizList: quizViewModel.getListQuestionsForCategory("Burn"),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class QuizCategoryItem extends StatelessWidget {
  final String title;
  final String tag;
  final Color tagColor;
  final VoidCallback onTap;

  QuizCategoryItem({
    required this.title,
    required this.tag,
    required this.tagColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 24 * scaler.widthScaleFactor, top: 8 * scaler.widthScaleFactor, right: 8 * scaler.widthScaleFactor, bottom: 8 * scaler.widthScaleFactor),
        decoration: BoxDecoration(
          color: Colors.grey[300]?.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16 * scaler.widthScaleFactor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18 * scaler.widthScaleFactor / scaler.textScaleFactor,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 4 * scaler.widthScaleFactor),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4 * scaler.widthScaleFactor, horizontal: 8 * scaler.widthScaleFactor),
              decoration: BoxDecoration(
                color: tagColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
              ),
              child: Text(
                tag,
                style: TextStyle(
                    color: tagColor,
                    fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                    fontWeight: FontWeight.normal
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}