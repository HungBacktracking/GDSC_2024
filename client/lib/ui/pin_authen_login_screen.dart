import 'package:client/ui/greeting_screen.dart';
import 'package:client/ui/home_screen.dart';
import 'package:client/ui/phone_input_login_screen.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

import '../utils/strings.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';
import '../widgets/custom_outline_button.dart';

class PinAuthenticationLogin extends StatefulWidget {
  const PinAuthenticationLogin ( {super.key, required this.phoneNumber} );

  final String phoneNumber;

  @override
  State<PinAuthenticationLogin> createState() => PinAuthenticationLoginState();
}

class PinAuthenticationLoginState extends State<PinAuthenticationLogin> {
  static const Color _accent = Color(0xff112950);
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    focusNode.dispose();
    pinController.dispose();
    super.dispose();
  }

  void onTapClose(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const GreetingScreen()),
          (Route<dynamic> route) => false,
    );
  }

  void onTapChangePhone(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const PhoneInputLogin();
        },
      ),
    );
  }

  void handleCorrectPin(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const HomeScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(21, 101, 192, 1);
    final Size screen_size = MediaQuery.of(context).size;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = _accent;

    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Colors.transparent,
              height: screen_size.height,
              width: screen_size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.clear),
                        onPressed: () => onTapClose(context),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.pin_authentication_title,
                        style: MyStyles.headerTextStyle,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.pin_authentication_guide,
                        style: MyStyles.blackTinyTextStyle,
                      ),
                    ),
                  ),
                  const Gap(20),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 6,
                            controller: pinController,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) => const SizedBox(width: 8),
                            validator: (value) {
                              return value == '222222' ? null : 'Wrong pin';
                            },
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              debugPrint('onCompleted: $pin');
                            },
                            onChanged: (value) {
                              debugPrint('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              height: 52,
                              width: 52,
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                        const Gap(30),
                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You didn\'t get the code?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text('Resend code via SMS in 01:30'),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  minimumSize: const Size(0, 40),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Resend code',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        Container(
                          margin: const EdgeInsets.only(left: 16, right: 16),
                          child: CustomFilledButton(
                              label: 'Next',
                              onPressed: () {
                                focusNode.unfocus();
                                formKey.currentState!.validate()
                                    ? handleCorrectPin(context)
                                    : null;
                              }),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomOutlinedButton(
                      label: "Change mobile number",
                      onPressed: () => onTapChangePhone(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}