import 'package:client/model/quiz_category_model.dart';
import 'package:client/ui/quiz_game_screen.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
            'LEARNING FIRST AID',
            style: TextStyle(
              color: MyTheme.blueBorder,
              fontWeight: FontWeight.w500,
            ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.w600), // Default text style
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
                    radius: 20, // Adjust the size as needed
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'What do you want to learn today?',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  )
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),


              //challenge you
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
                child: Row(
                  children: [
                    Image.asset('assets/icons/ic_challenge_you.png', width: 38, height: 38), // Adjust the size as needed
                    const SizedBox(width: 8),
                    const Text(
                      'Challenge You',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyTheme.blueBorder,
                      ),
                    ),
                  ],
                ),
              ),
              CategoryGrid(challengeYouCategories),
              Padding(
                padding: const EdgeInsets.only(top: 25.0, bottom: 8.0),
                child: Row(
                  children: [
                    Image.asset('assets/icons/ic_topic.png', width: 38, height: 38), // Adjust the size as needed
                    const SizedBox(width: 8),
                    const Text(
                      'Topics',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: MyTheme.blueBorder,
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
    );
  }
}

class CategoryGrid extends StatelessWidget {
  final List<QuizCategoryModel> categories;

  CategoryGrid(this.categories);

  @override
  Widget build(BuildContext context) {
    // Calculate the aspect ratio based on desired item width and height
    double itemWidth = 170; // Desired item width
    double itemHeight = 90; // Desired item height
    double screenWidth = MediaQuery.of(context).size.width; // Get screen width
    double crossAxisSpacing = 16; // Adjust as needed
    double mainAxisSpacing = 16; // Adjust as needed
    int crossAxisCount = 2; // Number of items per row
    double totalHorizontalPadding = 32; // Adjust as needed
    double totalCrossAxisSpacing = (crossAxisCount - 1) * crossAxisSpacing;

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
        return CategoryItem(
          title: categories[index].title,
          tag: categories[index].tag,
          tagColor: categories[index].tagColor, // Pass the tag color
          onTap: () {
            // Handle the tap event. For example:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(),
              ),
            );
          },
        );
      },
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final String tag;
  final Color tagColor;
  final VoidCallback onTap;

  CategoryItem({
    required this.title,
    required this.tag,
    required this.tagColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyTheme.lightRedBackGround,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: tagColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tag,
                style: TextStyle(color: tagColor, fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}