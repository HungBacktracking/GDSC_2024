import 'package:client/ui/phone_input_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../utils/scaler.dart';
import '../utils/strings.dart';
import '../utils/styles.dart';
import '../utils/themes.dart';
import '../widgets/custom_filled_button.dart';


class VolunteerRegister extends StatefulWidget {
  final String name;

  const VolunteerRegister({super.key, required this.name});

  @override
  State<VolunteerRegister> createState() => VolunteerRegisterState();
}

class VolunteerRegisterState extends State<VolunteerRegister> {
  int option = 0;

  void handleSubmit(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return PhoneInputRegister(name: widget.name, optionVolunteer: option);
        },
      ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 0, top: 10 * scaler.widthScaleFactor),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios, // Cupertino uses 'Icons.arrow_back_ios_new' for newer iOS style
                        size: 25 * scaler.widthScaleFactor, // Set your custom size
                      ),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, top: 5 * scaler.widthScaleFactor),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      MyStrings.volunteer_register_title,
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
                      MyStrings.volunteer_register_guide,
                      style: TextStyle(
                          fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                Gap(20 * scaler.widthScaleFactor),

                Container(
                  margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepOrange[200]!, // Adjust the color and opacity
                        blurRadius: 0.001, // Blur radius
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RadioListTile<int>(
                        contentPadding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 10 * scaler.widthScaleFactor),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                            MyStrings.volunteer_register_option_1,
                            style: TextStyle(
                                fontSize: 18 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                fontWeight: FontWeight.w500
                            )
                        ),
                        value: 0,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value!;
                          });
                        },
                      ),
                      Divider(
                        height: 1 * scaler.widthScaleFactor,
                        color: Colors.grey[200],
                      ),
                      RadioListTile<int>(
                        contentPadding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 10 * scaler.widthScaleFactor),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                            MyStrings.volunteer_register_option_2,
                            style: TextStyle(
                                fontSize: 18 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                fontWeight: FontWeight.w500
                            )
                        ),
                        value: 1,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value!;
                          });
                        },
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey[200],
                      ),
                      RadioListTile<int>(
                        contentPadding: const EdgeInsets.only(left: 16, right: 10),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                            MyStrings.volunteer_register_option_3,
                            style: TextStyle(
                              fontSize: 18 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                  fontWeight: FontWeight.w500
                              ),
                      ),
                        subtitle: Text(
                            MyStrings.volunteer_register_option_3_,
                          style: TextStyle(
                              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                        value: 2,
                        groupValue: option,
                        onChanged: (int? value) {
                          setState(() {
                            option = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Gap(30 * scaler.widthScaleFactor),
                Container(
                  margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                  child: CustomFilledButton(
                    label: "Next",
                    onPressed: () => handleSubmit(context),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, bottom: 5 * scaler.widthScaleFactor),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        MyStrings.already_have_account,
                        style: TextStyle(
                            fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            color: Colors.deepOrangeAccent
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