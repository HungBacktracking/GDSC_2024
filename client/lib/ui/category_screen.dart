import 'package:flutter/material.dart';
import '../models/sub_category_model.dart';
import '../utils/scaler.dart';
import '../view_model/step_viewmodel.dart';
import 'firstaid_steps_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String screenTitle;
  final List<CategoryItem> categories;

  CategoryScreen({required this.screenTitle, required this.categories});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            screenTitle,
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
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return SubCategoryTag(category: categories[index]);
        },
      ),
    );
  }
}

class SubCategoryTag extends StatelessWidget {
  final CategoryItem category;

  SubCategoryTag({required this.category});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Container(
      height: 70.0 * scaler.widthScaleFactor,
      margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor, vertical: 5.0 * scaler.widthScaleFactor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor),
        color : Colors.grey[300]?.withOpacity(0.3),
      ),
      child: InkWell(
        onTap: () {
          StepViewModel stepViewModel = StepViewModel();
          // Handle the tap event for this category
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepScreen(
                appBarTitle: category.title,
                steps: stepViewModel.getStepsForCategory(category.steps_name),
                youtubeId: category.youtubeId,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.only(top: 12.0 * scaler.widthScaleFactor, bottom: 12.0 * scaler.widthScaleFactor, left: 20.0 * scaler.widthScaleFactor, right: 5.0 * scaler.widthScaleFactor), // Add padding to all sides
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(1.0), // The size of the border
                decoration: BoxDecoration(
                  color: Colors.transparent, // Border color
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.deepOrangeAccent, // Set border color
                    width: 0.5, // Set border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 20.0 * scaler.widthScaleFactor,
                  backgroundImage: AssetImage(category.iconPath),
                  backgroundColor: Colors.transparent,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 15.0 * scaler.widthScaleFactor),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    category.title,
                    style: TextStyle(
                        fontSize: 20.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10.0 * scaler.widthScaleFactor),
                child: Icon(Icons.arrow_forward_ios, size: 20.0 * scaler.widthScaleFactor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

