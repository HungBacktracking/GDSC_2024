import 'package:client/ui/phone_input_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../utils/strings.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';
import '../widgets/custom_filled_button.dart';
import 'home_screen.dart';


class VolunteerRegister extends StatefulWidget {
  const VolunteerRegister({super.key});

  @override
  State<VolunteerRegister> createState() => VolunteerRegisterState();
}

class VolunteerRegisterState extends State<VolunteerRegister> {
  int? option = 0; // Default or saved user choice

  void handleSubmit(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const PhoneInputRegister();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 0, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: CupertinoNavigationBarBackButton(
                      color: Colors.black,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyStrings.volunteer_register_title,
                      style: MyStyles.headerTextStyle,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyStrings.volunteer_register_guide,
                      style: MyStyles.blackTinyTextStyle,
                    ),
                  ),
                ),
                Gap(20),
                Card(
                  borderOnForeground: true,
                  shadowColor: Colors.deepOrange[200],
                  surfaceTintColor: Colors.white,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  elevation: 5,
                  child: Column(
                    children: [
                      RadioListTile<int>(
                        contentPadding: EdgeInsets.only(left: 16, right: 10),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: const Text(MyStrings.volunteer_register_option_1),
                        value: 0,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value;
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),
                      RadioListTile<int>(
                        contentPadding: EdgeInsets.only(left: 16, right: 10),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: const Text(MyStrings.volunteer_register_option_2),
                        value: 1,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value;
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),
                      RadioListTile<int>(
                        contentPadding: EdgeInsets.only(left: 16, right: 10),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: const Text(MyStrings.volunteer_register_option_3),
                        subtitle: const Text(MyStrings.volunteer_register_option_3_),
                        value: 2,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Gap(30),
                Container(
                  margin: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomFilledButton(
                    label: "Next",
                    onPressed: () => handleSubmit(context),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        MyStrings.already_have_account,
                        style: TextStyle(fontSize: 16, color: Colors.deepOrangeAccent),
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