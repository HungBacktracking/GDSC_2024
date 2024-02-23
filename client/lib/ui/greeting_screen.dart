import 'package:client/utils/styles.dart';
import 'package:client/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/spacer.dart';
import '../utils/strings.dart';
import '../utils/themes.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10.0),
                  child: HeaderWidget()
              ),
              Gap(15),
              Image.asset('assets/images/greeting_image.png'),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  Strings.greeting_text,
                  // style: MyStyles.tinyTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(70),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {  },
                    style: FilledButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                        'Login',
                        // style: MyStyles.tinyBoldTextStyle,
                    ),
                  ),
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {  },
                    style: OutlinedButton.styleFrom(
                      elevation: 5,
                      side: BorderSide(color: Colors.deepOrangeAccent, width: 1.0),
                      foregroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.deepOrangeAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}