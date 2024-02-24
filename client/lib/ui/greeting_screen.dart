import 'package:client/utils/styles.dart';
import 'package:client/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';


import '../utils/scaler.dart';
import '../utils/strings.dart';
import '../utils/themes.dart';
import '../view_model/auth_viewmodel.dart';
import 'name_input_register.dart';
import 'phone_input_login_screen.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({super.key});

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {

  onTapLogin(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PhoneInputLogin())
    );
  }

  onTapSignup(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const NameInputRegister())
    );
  }

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          child: Container(
            color: Colors.transparent,
            height: screen_size.height,
            width: screen_size.width,
            child: Column(
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
                Gap(20 * scaler.widthScaleFactor),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0 * scaler.widthScaleFactor),
                  child: Text(
                    MyStrings.greeting_text,
                    style: TextStyle(
                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(70),
                Padding(
                  padding: EdgeInsets.only(left: 30.0 * scaler.widthScaleFactor, right: 30.0 * scaler.widthScaleFactor),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => onTapLogin(context),
                      style: FilledButton.styleFrom(
                        elevation: 5 * scaler.widthScaleFactor,
                        backgroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0 * scaler.widthScaleFactor),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
                      ),
                      child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                              fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Gap(10 * scaler.widthScaleFactor),
                Padding(
                  padding: EdgeInsets.only(left: 30.0 * scaler.widthScaleFactor, right: 30.0 * scaler.widthScaleFactor),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => onTapSignup(context),
                      style: OutlinedButton.styleFrom(
                        elevation: 5 * scaler.widthScaleFactor,
                        side: BorderSide(color: Colors.deepOrangeAccent, width: 1.0 * scaler.widthScaleFactor),
                        foregroundColor: Colors.deepOrangeAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0 * scaler.widthScaleFactor),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                          fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, bottom: 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        MyStrings.privacy,
                        style: TextStyle(
                            fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            color: grey
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}