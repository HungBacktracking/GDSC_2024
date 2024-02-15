import 'dart:io';

import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 80,
          color: MyTheme.lightRedBackGround,
          child: Row(
            children: [
              navItem(
                "assets/icons/ic_home.png",
                "Home",
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                "assets/icons/ic_news.png",
                "News",
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 80),
              navItem(
                "assets/icons/ic_leaderboard.png",
                "Leaderboard",
                pageIndex == 2,
                onTap: () => onTap(2),
              ),
              navItem(
                "assets/icons/ic_profile.png",
                "Profile",
                pageIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(String assetPath, String label, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              assetPath,
              height: 24, // Adjust the height as needed
              color: selected ? MyTheme.redBorder : Colors.black,
            ),
            const SizedBox(height: 4), // Adjust the spacing between icon and label
            Text(
              label,
              style: TextStyle(
                color: selected ? MyTheme.redBorder : Colors.black,
                fontSize: 12, // Adjust the font size as needed
              ),
            ),
          ],
        ),
      ),
    );
  }

}