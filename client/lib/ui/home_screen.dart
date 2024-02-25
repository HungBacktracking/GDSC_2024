import 'package:client/ui/category_screen.dart';
import 'package:client/ui/learning_firstaid_screen.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../models/quiz_category_model.dart';
import '../models/sub_category_model.dart';
import '../utils/scaler.dart';
import '../utils/strings.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/header_widget.dart';
import '../widgets/home_nav_tag.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAllCategories = false;

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

  @override
  Widget build(BuildContext context) {
    List Titles = [
      'CPR',
      'Bleeding',
      'Poisons',
      'Burn',
      'Fracture',
      'Bite',
      'Choking',
      'Electric Shock',
      'Drug Overdose',
      'Diabetes',
      'Eye Injury',
    ];

    List Category_Icons = [
      "assets/icons/CPR.png",
      "assets/icons/Bleeding.png",
      "assets/icons/Poisons.png",
      "assets/icons/Burn.png",
      "assets/icons/Fracture.png",
      "assets/icons/Bite.png",
      "assets/icons/Choking.png",
      "assets/icons/ElectricShock.png",
      "assets/icons/DrugOverdose.png",
      "assets/icons/Diabetes.png",
      "assets/icons/EyeInjury.png",
    ];

    Scaler().init(context);
    final scaler = Scaler();

    final Size screen_size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Column(
            children: [
              Container(
                  color: Colors.transparent,
                  width: screen_size.width,
                  height: screen_size.height - 150 * scaler.widthScaleFactor,
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.0 * scaler.widthScaleFactor, bottom: 20.0 * scaler.widthScaleFactor, top: 10.0 * scaler.widthScaleFactor),
                            child: HeaderWidget()
                          ),
                          Gap(15 * scaler.widthScaleFactor),
                          // a search box, with a search icon first
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor),
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
                                fillColor: Colors.grey[100],
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0 * scaler.widthScaleFactor),
                              ),
                              style: TextStyle(
                                fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor, // Specify the font size of the text
                              ),
                            ),
                          ),
                          Gap(25 * scaler.widthScaleFactor),
                          // a list of categories
                          GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:  3,
                                crossAxisSpacing: 10 * scaler.widthScaleFactor,
                                mainAxisSpacing: 10 * scaler.widthScaleFactor,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: showAllCategories ? Titles.length : 6,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    List<CategoryItem> cprCategories = [
                                      CategoryItem(title: 'Adult', iconPath: 'assets/icons/ic_adult.png', steps_name: "CPR for Adult", youtubeId: "-NodDRTsV88"),
                                      CategoryItem(title: 'Child', iconPath: 'assets/icons/ic_child.png', steps_name: "CPR for Child", youtubeId: "lDFN1bgdAqM"),
                                      CategoryItem(title: 'Baby', iconPath: 'assets/icons/ic_baby.png', steps_name: "CPR for Baby", youtubeId: "gHZdBY-CkGw"),
                                    ];

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryScreen(screenTitle: 'CPR', categories: cprCategories),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical : 4 * scaler.widthScaleFactor, horizontal: 4 * scaler.widthScaleFactor),
                                    padding: EdgeInsets.only(top: 8 * scaler.widthScaleFactor),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15 * scaler.widthScaleFactor),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 1 * scaler.widthScaleFactor,
                                          blurRadius: 5 * scaler.widthScaleFactor,
                                          offset: const Offset(0, 2), // changes position of shadow
                                        ),
                                      ]
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          Category_Icons[index],
                                          height: 55 * scaler.widthScaleFactor,
                                          width: 55 * scaler.widthScaleFactor,
                                        ),
                                        SizedBox(height: 8 * scaler.widthScaleFactor),
                                        Text(
                                          Titles[index],
                                          style: TextStyle(
                                            fontSize: 15 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Inter"
                                          ),
                                        ),
                                      ],
                                    ),
                                )
                                );
                              }),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor, vertical: 10.0 * scaler.widthScaleFactor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showAllCategories = !showAllCategories;
                                    });
                                  },
                                  child: Text(
                                    showAllCategories ? MyStrings.viewLess_text : MyStrings.viewAll_text,
                                    style: TextStyle(
                                      fontSize: 20 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Inter",
                                      color: MyTheme.lightBlue,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          Gap(20 * scaler.widthScaleFactor),
                          SizedBox(
                            height: 90.0 * scaler.widthScaleFactor,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LearningFirstAidScreen(userName: 'Rohan', avatarUrl: 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', challengeYouCategories: challengeYouCategories, topicsCategories: topicsCategories)),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor),
                                child:  const HomeNavigationTag(
                                  assetUrl: 'assets/icons/ic_school.png',
                                  tittle: "LEARNING FIRST AID",
                                  subTittle: "Play a game",
                                  textColor: MyTheme.Blue,
                                ),
                              ),
                            ),
                          ),
                          Gap(20 * scaler.widthScaleFactor),
                          SizedBox(
                            height: 90.0 * scaler.widthScaleFactor,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.0 * scaler.widthScaleFactor),
                              child:  const HomeNavigationTag(
                                assetUrl: 'assets/icons/ic_volunteer.png',
                                tittle: "BE VOLUNTEER",
                                subTittle: "Help more people",
                                textColor: MyTheme.darkGreen,
                              ),
                            ),
                          )
                        ],
                    ),
                  ),
              ),
              const Spacer(),
              const CustomNavigationBar(indexes: [true, false, false, false]),
            ],
          ),
        ),
      ),
    );
  }
}



