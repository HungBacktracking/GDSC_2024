import 'package:client/ui/category_screen.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../model/sub_category_model.dart';
import '../utils/strings.dart';
import '../widgets/header_widget.dart';
import '../widgets/home_nav_tag.dart';
import 'all_category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showAllCategories = false;

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

    final Size screen_size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            color: Colors.transparent,
            height: screen_size.height,
            width: screen_size.width,
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10.0),
                      child: HeaderWidget()
                    ),
                    Gap(15),
                    // a search box, with a search icon first
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: MyTheme.greenGray
                        ),
                      ),
                    ),
                    const Gap(25),
                    // a list of categories
                    GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: showAllCategories ? Titles.length : 6,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              List<CategoryItem> cprCategories = [
                                CategoryItem(title: 'Adult', iconPath: 'assets/icons/ic_adult.png'),
                                CategoryItem(title: 'Child', iconPath: 'assets/icons/ic_child.png'),
                                CategoryItem(title: 'Baby', iconPath: 'assets/icons/ic_baby.png'),
                              ];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(screenTitle: 'CPR', categories: cprCategories),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical : 4, horizontal: 4),
                              padding: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: MyTheme.lightRedBackGround,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2), // changes position of shadow
                                  ),
                                ]
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Category_Icons[index],
                                    height: 55,
                                    width: 55,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    Titles[index],
                                    style: TextStyle(
                                      fontSize: 15,
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
                      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                              showAllCategories ? Strings.viewLess_text : Strings.viewAll_text,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                                color: MyTheme.lightBlue,
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    const Gap(20)
                    ,
                    SizedBox(
                      height: 90.0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const HomeNavigationTag(
                          assetUrl: 'assets/icons/ic_school.png',
                          tittle: "LEARNING FIRST AID",
                          subTittle: "Play a game",
                          textColor: MyTheme.Blue,
                        ),
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      height: 90.0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: const HomeNavigationTag(
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
      ),
    );
  }
}



