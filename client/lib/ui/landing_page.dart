import 'package:client/ui/greeting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../utils/scaler.dart';
import '../utils/themes.dart';
import '../widgets/header_widget.dart';
import 'main_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();

    final Size screen_size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 2), () => FirebaseAuth.instance.currentUser),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const MainScreen()));
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const GreetingScreen()));
            });
          }
        }


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
                          margin: EdgeInsets.only(left: 20.0 * scaler.widthScaleFactor, bottom: 20.0 * scaler.widthScaleFactor, top: 10.0 * scaler.widthScaleFactor),
                          child: const HeaderWidget()
                      ),
                      Gap(15 * scaler.widthScaleFactor),
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
      },
    );
  }
}