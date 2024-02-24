import 'package:flutter/material.dart';

import '../utils/scaler.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
    );
  }
}