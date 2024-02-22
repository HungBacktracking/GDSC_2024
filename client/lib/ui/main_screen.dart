import 'package:client/ui/all_category_screen.dart';
import 'package:client/ui/home_screen.dart';
import 'package:client/ui/leader_board_screen.dart';
import 'package:client/ui/profile_screen.dart';
import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

import '../model/nav_model.dart';
import '../widgets/nav_bar.dart';
import 'sos_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final learderBoardNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
        page: const HomeScreen(),
        navKey: homeNavKey,
      ),
      NavModel(
        page: const AllCategoryScreen(),
        navKey: searchNavKey,
      ),
      NavModel(
        page: LeaderboardScreen(),
        navKey: learderBoardNavKey,
      ),
      NavModel(
        page: const ProfileScreen(avatarUrl: 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', userName: 'Nguyen Tan',),
        navKey: profileNavKey,
      ),
    ];
  }

  void onTapSOSCall(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return const SOSScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navKey.currentState?.canPop() ?? false) {
          items[selectedTab].navKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
            key: page.navKey,
            onGenerateInitialRoutes: (navigator, initialRoute) {
              return [
                MaterialPageRoute(builder: (context) => page.page)
              ];
            },
          ))
              .toList(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 70,
          width: 70,
          child: FloatingActionButton(
            backgroundColor: MyTheme.orangeLight,
            elevation: 0,
            onPressed: () => onTapSOSCall(context),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 4, color: MyTheme.orange),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/icons/ic_sos.png', // Replace with your actual icon path
              height: 50, // Adjust the height as needed
            ),
          ),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final int tab;

  const TabPage({Key? key, required this.tab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tab $tab')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tab $tab'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Page(tab: tab),
                  ),
                );
              },
              child: const Text('Go to page'),
            )
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final int tab;

  const Page({super.key, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Tab $tab')),
      body: Center(child: Text('Tab $tab')),
    );
  }
}