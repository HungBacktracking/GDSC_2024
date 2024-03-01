import 'package:camera/camera.dart';
import 'package:client/ui/home_screen.dart';
import 'package:client/ui/leader_board_screen.dart';
import 'package:client/ui/learning_firstaid_screen.dart';
import 'package:client/ui/profile_screen.dart';
import 'package:client/ui/sos/sos_screen.dart';
import 'package:client/ui/sos/victim_capture_screen.dart';
import 'package:flutter/material.dart';

import '../models/quiz_category_model.dart';
import '../utils/scaler.dart';

class CustomNavigationBar extends StatelessWidget{
  final List<bool> indexes;

  const CustomNavigationBar({super.key, required this.indexes});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Stack(
        clipBehavior: Clip.none,
        children:[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 20.0 * scaler.widthScaleFactor,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
              BottomBar(
                indexes: indexes,
              ),
            ],
          ),
          Center(
            child: CircleAvatar(
                radius: 40.0 * scaler.widthScaleFactor,
                backgroundColor: Colors.grey[200],
                child: InkWell(
                  onTap: () async {
                    // Obtain a list of the available cameras on the device.
                    final cameras = await availableCameras();

                    // Get a specific camera from the list of available cameras.
                    final firstCamera = cameras.first;

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VictimCaptureScreen(camera: firstCamera)),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/ic_sos.png',
                    height: 100.0 * scaler.widthScaleFactor,
                    width: 100.0 * scaler.widthScaleFactor,
                  ),
                )
            ),
          ),
        ]
    );
  }

}

class BottomBar extends StatelessWidget {
  final List<bool> indexes;
  const BottomBar({super.key, required this.indexes});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Container(
      height: 65 * scaler.heightScaleFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[300]!.withOpacity(0.4),
            width: 1,
          ),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10 * scaler.widthScaleFactor),
          bottomRight: Radius.circular(10 * scaler.widthScaleFactor),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.0 * scaler.widthScaleFactor, right: 10.0 * scaler.widthScaleFactor, top: 5.0 * scaler.heightScaleFactor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationItem(
              title: 'Home',
              icon: Image.asset('assets/icons/ic_home.png', width: 30 * scaler.widthScaleFactor, height: 30 * scaler.heightScaleFactor, color: indexes[0] == true ? Colors.deepOrange : Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              isCurrent: indexes[0],
            ),
            NavigationItem(
              title: 'News',
              icon: Image.asset('assets/icons/ic_news.png', width: 30 * scaler.widthScaleFactor, height: 30 * scaler.heightScaleFactor, color: indexes[1] == true ? Colors.deepOrange : Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen(avatarUrl: 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', userName: 'Nguyen Tan')),
                      (Route<dynamic> route) => false,
                );
              },
              isCurrent: indexes[1],
            ),

            SizedBox(width: 40 * scaler.widthScaleFactor),

            NavigationItem(
              title: 'Ranking',
              icon: Image.asset('assets/icons/ic_leaderboard.png', width: 30 * scaler.widthScaleFactor, height: 30 * scaler.heightScaleFactor, color: indexes[2] == true ? Colors.deepOrange : Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()),
                      (Route<dynamic> route) => false,
                );
              },
              isCurrent: indexes[2],
            ),
            NavigationItem(
              title: 'Profile',
              icon: Image.asset('assets/icons/ic_profile.png', width: 30 * scaler.widthScaleFactor, height: 30 * scaler.heightScaleFactor, color: indexes[3] == true ? Colors.deepOrange : Colors.black),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen(avatarUrl: 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', userName: 'Nguyen Tan')),
                      (Route<dynamic> route) => false,
                );
              },
              isCurrent: indexes[3],
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem extends StatelessWidget{
  final String title;
  final Widget icon;
  final VoidCallback onPressed;
  final bool isCurrent;

  const NavigationItem({super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    return InkWell(
      onTap:() {
        if (isCurrent == false){
          onPressed();
        }
        },
      child: Column(
      mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text(
            title,
            style: TextStyle(
                fontSize: 12 * Scaler().widthScaleFactor,
                fontWeight: FontWeight.w500,
                color: isCurrent == true ? Colors.deepOrange : Colors.black
            ),
          )
        ],
      ),
    );
  }
}