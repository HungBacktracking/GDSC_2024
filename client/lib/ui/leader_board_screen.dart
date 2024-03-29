import 'package:client/utils/themes.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/nav_bar.dart';

class LeaderboardScreen extends StatelessWidget {
  final User you =  User('Ali Baba', '159 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 1);
  final List<User> users = [
    User('Ali Baba', '159 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 1),
    User('Black hair', '100 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 2),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 3),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 4),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 5),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 6),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 7),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 8),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 9),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 11),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 10),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 13),
    User('Kudo Shinichi', '89 cases', 'https://i1-giaitri.vnecdn.net/2022/06/25/lan-nha-1-JPG-2518-1656130984.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=KG41XneV1XWJx66-iZtinA', rank: 12),
    // Add other users here...
  ];

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    users.sort((a, b) => a.rank.compareTo(b.rank));
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          'Leader board',
          style: TextStyle(
            fontSize: 20.0  * scaler.widthScaleFactor/ scaler.textScaleFactor,
            fontWeight: FontWeight.w700,
            color: Colors.black,
        ),
      ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body:
      Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 200 * scaler.widthScaleFactor,
            child: Padding(
              padding: EdgeInsets.only(left: 16.0 * scaler.widthScaleFactor, right: 16.0 * scaler.widthScaleFactor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                      children:
                        [
                          TopUserWidget(user: users[1], size: 40 * scaler.widthScaleFactor, numberBackgroundColor: MyTheme.lightBlue),
                          TopUserWidget(user: users[0], size: 60 * scaler.widthScaleFactor, numberBackgroundColor: MyTheme.orangeColor),
                          TopUserWidget(user: users[2], size: 40 * scaler.widthScaleFactor, numberBackgroundColor: MyTheme.darkGreen),
                        ]
                ),
                  SizedBox(height: 30 * scaler.widthScaleFactor),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length - 3,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              // Handle user tap
                            },
                            child: CustomListTile(
                              rank: users[index+3].rank,
                              name: users[index+3].name,
                              score: users[index+3].score,
                              avatarUrl: users[index+3].avatar,
                            ),
                          ),
                          Divider(
                            color: Colors.grey[400],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                  SizedBox(height: 10 * scaler.widthScaleFactor),
                  Image.asset('assets/icons/ic_3dot.png', fit: BoxFit.cover),
                  SizedBox(height: 10 * scaler.widthScaleFactor),
                  CustomListTile(rank: you.rank, name: you.name, score: you.score, avatarUrl: you.avatar, backgroundColor: Colors.grey[300]?.withOpacity(0.3)),
                ]
              ),
            ),
          ),
          Spacer(),
          CustomNavigationBar(indexes: [false, false, true, false],),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final int rank;
  final String name;
  final String score;
  final String avatarUrl;
  final Color? backgroundColor;

  const CustomListTile({
    Key? key,
    required this.rank,
    required this.name,
    required this.score,
    required this.avatarUrl,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0 * scaler.widthScaleFactor),
        color: backgroundColor ?? Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0 * scaler.widthScaleFactor, horizontal: 16.0 * scaler.widthScaleFactor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '$rank',
                  style: TextStyle(
                      fontSize: 15.0 * scaler.widthScaleFactor/ scaler.textScaleFactor,
                      fontWeight: FontWeight.w400
                  )
              ),
              SizedBox(width: 16.0 * scaler.widthScaleFactor),
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                // If you want to add a border around the CircleAvatar:
                radius: 20.0 * scaler.widthScaleFactor,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0 * scaler.widthScaleFactor),
                  child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ),
              Text(
                  score,
                  style: TextStyle(
                      fontSize: 16.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                      fontWeight: FontWeight.w600,
                  )
              ),
            ],
          ),
      ),
    );
  }
}

class TopUserWidget extends StatelessWidget {
  final User user;
  final double size; // Add size parameter
  final Color numberBackgroundColor;

  const TopUserWidget({
    Key? key,
    required this.user,
    required this.size,
    required this.numberBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                SizedBox(height: 8 * scaler.widthScaleFactor),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: numberBackgroundColor.withOpacity(0.5),
                      width: 2 * scaler.widthScaleFactor,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5 * scaler.widthScaleFactor,
                        spreadRadius: 2 * scaler.widthScaleFactor,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: size,
                    backgroundImage: NetworkImage(user.avatar), // Use NetworkImage
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(height: size/3)
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2 * scaler.widthScaleFactor,
                ),
              ),
              child: CircleAvatar(
                radius: size / 3, // Adjust rank circle size relative to avatar
                backgroundColor: numberBackgroundColor,
                child: Text(
                  user.rank.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size / 3, // Adjust font size relative to avatar
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8 * scaler.widthScaleFactor),
        Text(
          user.name,
          style: TextStyle(
              fontSize: 18.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(
            user.score,
            style: TextStyle(
                fontSize: 16.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                fontWeight: FontWeight.w400
            ),
        ),
      ],
    );
  }
}

class User {
  final String name;
  final String score;
  final String avatar;
  final int rank;

  User(this.name, this.score, this.avatar, {this.rank = 0});
}
