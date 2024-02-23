import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/sub_category_model.dart';
import '../utils/themes.dart';
import 'firstaid_steps_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String screenTitle;
  final List<CategoryItem> categories;

  CategoryScreen({required this.screenTitle, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            screenTitle,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
    return Card(
      color : MyTheme.lightRedBackGround,
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          // Handle the tap event for this category
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StepScreen(
                appBarTitle: 'CPR for Adult',
                steps: const [
                  'Check for danger',
                  'Check the victim’s response',
                  'Clear and open the airway',
                  'If not breathing, begin CPR',
                  'Children (1-8 yrs) and babies',
                  'Give 30 check compressions',
                  'Then give 2 rescue breaths',
                  'AAb',
                  'cccd',
                  'dd',
                ],
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 15.0, right: 5.0), // Add padding to all sides
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(category.iconPath),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    category.title,
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

