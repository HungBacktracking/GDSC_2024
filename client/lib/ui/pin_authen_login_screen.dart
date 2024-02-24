import 'package:client/ui/greeting_screen.dart';
import 'package:client/ui/home_screen.dart';
import 'package:client/ui/phone_input_login_screen.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../utils/helper.dart';
import '../utils/scaler.dart';
import '../utils/strings.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';
import '../view_model/auth_viewmodel.dart';
import '../widgets/custom_outline_button.dart';
import 'main_screen.dart';

class PinAuthenticationLogin extends StatefulWidget {
  const PinAuthenticationLogin ( {
    super.key,
    required this.verificationId,
    required this.phoneNumber
  } );

  final String verificationId;
  final String phoneNumber;

  @override
  State<PinAuthenticationLogin> createState() => PinAuthenticationLoginState();
}

class PinAuthenticationLoginState extends State<PinAuthenticationLogin> {
  static const Color _accent = Color(0xff112950);
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool isProcessing = false;

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

  Future<void> handleValidPin(BuildContext context) async {
    setState(() {
      isProcessing = true;
    });

    final authenViewModel = Provider.of<AuthViewModel>(context, listen: false);
    await authenViewModel.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: pinController.text,
      onSuccess: () async {
        setState(() {
          isProcessing = false;
        });
        getSuccessSnackBar("Successfully logged in!");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              }
          ),
              (Route<dynamic> route) => false,
        );
      }
    );

    setState(() {
      isProcessing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    final scaler = Scaler();
    const focusedBorderColor = Color.fromRGBO(21, 101, 192, 1);
    final Size screen_size = MediaQuery.of(context).size;
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = _accent;

    final defaultPinTheme = PinTheme(
      width: 48 * scaler.widthScaleFactor,
      height: 48 * scaler.widthScaleFactor,
      textStyle: TextStyle(
        fontSize: 22 * scaler.widthScaleFactor / scaler.textScaleFactor,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
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
                    padding: EdgeInsets.only(left: 0, top: 10 * scaler.widthScaleFactor),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(CupertinoIcons.clear),
                        onPressed: () => onTapClose(context),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16.0 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, top: 5 * scaler.widthScaleFactor),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.pin_authentication_title,
                        style: TextStyle(
                            fontSize: 24 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, top: 5 * scaler.widthScaleFactor),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.pin_authentication_guide,
                        style: TextStyle(
                            fontSize: 16 * scaler.widthScaleFactor/ scaler.textScaleFactor,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Gap(20 * scaler.widthScaleFactor),
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
                            separatorBuilder: (index) => SizedBox(width: 8 * scaler.widthScaleFactor),
                            validator: (value) {
                              return (value!.isNotEmpty && value.length == 6) ? null : 'Invalid pin!';
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
                                  margin: EdgeInsets.only(bottom: 9 * scaler.widthScaleFactor),
                                  width: 22 * scaler.widthScaleFactor,
                                  height: 1 * scaler.widthScaleFactor,
                                  color: focusedBorderColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              height: 52 * scaler.widthScaleFactor,
                              width: 52 * scaler.widthScaleFactor,
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                                border: Border.all(color: focusedBorderColor),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: fillColor,
                                borderRadius: BorderRadius.circular(10 * scaler.widthScaleFactor),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                        Gap(30 * scaler.widthScaleFactor),
                        Container(
                          margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'You didn\'t get the code?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor
                                    ),
                                  ),
                                  Text(
                                      'Resend code via SMS in 01:30',
                                      style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor
                                  ),
                                ),
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                                  ),
                                  minimumSize: Size(0, 40 * scaler.widthScaleFactor),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'Resend code',
                                  style: TextStyle(
                                    fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 28 * scaler.widthScaleFactor),
                        Container(
                          margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                          child: CustomFilledButton(
                              label: 'Next',
                              isLoading: isProcessing,
                              onPressed: isProcessing ? () {} : () {
                                focusNode.unfocus();
                                formKey.currentState!.validate()
                                    ? handleValidPin(context)
                                    : null;
                              }),
                        ),
                      ],
                    ),
                  ),
                  Gap(10 * scaler.widthScaleFactor),
                  Container(
                    margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
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