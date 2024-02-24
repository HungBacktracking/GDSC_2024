import 'package:client/utils/strings.dart';
import 'package:client/utils/styles.dart';
import 'package:client/utils/themes.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import '../../utils/scaler.dart';
import 'volunteer_register.dart';

class NameInputRegister extends StatefulWidget {
  const NameInputRegister({super.key});

  @override
  State<NameInputRegister> createState() => _NameInputRegisterState();
}

class _NameInputRegisterState extends State<NameInputRegister> {
  bool firstValidate = false;
  bool secondValidate = false;
  final _formKey = GlobalKey<FormState>();
  final FocusNode firstFocusNode = FocusNode();
  final FocusNode lastFocusNode = FocusNode();
  Color firstInputBorderColor = Colors.grey[300]!;
  Color lastInputBorderColor = Colors.grey[300]!;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(firstFocusNode);
    });

    firstFocusNode.addListener(() {
      if (firstFocusNode.hasFocus) {
        setState(() {
          firstInputBorderColor = Colors.grey[700]!;
        });
      } else {
        setState(() {
          firstInputBorderColor = Colors.grey[300]!;
        });
      }
    });

    lastFocusNode.addListener(() {
      if (lastFocusNode.hasFocus) {
        setState(() {
          lastInputBorderColor = Colors.grey[700]!;
        });
      } else {
        setState(() {
          lastInputBorderColor = Colors.grey[300]!;
        });
      }
    });
  }

  @override
  void dispose() {
    firstFocusNode.dispose();
    firstNameController.dispose();
    lastFocusNode.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  void onSubmitPhone(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String name = "$firstNameController.text $lastNameController.text";
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VolunteerRegister(name: name),
        ),
      );
    }
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
                        MyStrings.name_input_register_title,
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
                        MyStrings.name_input_register_guide,
                        style: TextStyle(
                            fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            color: Colors.black
                        ),
                      ),
                    ),
                  ),
                  Gap(10 * scaler.widthScaleFactor),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.all(16.0 * scaler.widthScaleFactor),
                      child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: firstInputBorderColor,
                                    width: 1.0 * scaler.widthScaleFactor,
                                  ),
                                  borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                                ),
                                child: TextFormField(
                                  focusNode: firstFocusNode,
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor, color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    label: const Text('First name'),
                                    labelStyle: TextStyle(
                                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        color: Colors.grey[300]
                                    ),
                                    floatingLabelStyle: TextStyle(
                                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        color: Colors.grey[700]
                                    ),
                                    errorStyle: TextStyle(
                                      fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                      color: MyTheme.redBtn,
                                    ),
                                    contentPadding: EdgeInsets.all(6 * scaler.widthScaleFactor),
                                    border: InputBorder.none,
                                    errorText: firstValidate ? 'Invalid name!' : null,
                                  ),
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    setState(() {
                                      firstNameController.text = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Gap(12 * scaler.widthScaleFactor),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: lastInputBorderColor,
                                    width: 1.0 * scaler.widthScaleFactor,
                                  ),
                                  borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                                ),
                                child: TextFormField(
                                  focusNode: lastFocusNode,
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                      color: Colors.black
                                  ),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Last name',
                                      style: TextStyle(
                                          fontSize: 16.0 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        color: Colors.grey[300]
                                    ),
                                    floatingLabelStyle: TextStyle(
                                        fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        color: Colors.grey[700]
                                    ),
                                    errorStyle: TextStyle(
                                        fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                                        color: MyTheme.redBtn,
                                    ),
                                    contentPadding: EdgeInsets.all(6 * scaler.widthScaleFactor),
                                    border: InputBorder.none,
                                    errorText: secondValidate ? 'Invalid name!' : null,
                                  ),
                                  keyboardType: TextInputType.name,
                                  onChanged: (value) {
                                    setState(() {
                                      lastNameController.text = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: 10 * scaler.widthScaleFactor),
                  Container(
                    margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                    child: CustomFilledButton(
                      label: "Next",
                      onPressed: () => onSubmitPhone(context),
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
      ),
    );
  }
}