import 'package:client/ui/greeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../utils/themes.dart';
import '../widgets/header_widget.dart';
import 'main_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screen_size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1), () => FirebaseAuth.instance.currentUser),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
              height: screen_size.height,
              width: screen_size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: MyTheme.defaultGradientColors
                  // colors: MyTheme.orangeGiftGradientColors,
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10.0),
                            child: const HeaderWidget()
                        ),
                        const Gap(15),
                        Container(
                          height: screen_size.height / 3,
                          width: screen_size.width,
                          child: Image.asset('assets/images/greeting_image.png', fit: BoxFit.contain,)
                        ),
                      ],
                    ),
                    const Expanded(
                        child: Center(child: CircularProgressIndicator())
                    )
                  ]
                )
              ),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          return const MainScreen();
        }
        return const GreetingScreen();
      },
    );
  }
}