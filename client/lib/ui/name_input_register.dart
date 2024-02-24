import 'package:client/utils/strings.dart';
import 'package:client/utils/styles.dart';
import 'package:client/utils/themes.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

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
                        MyStrings.name_input_register_title,
                        style: MyStyles.headerTextStyle,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.name_input_register_guide,
                        style: MyStyles.blackTinyTextStyle,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: firstInputBorderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextFormField(
                                focusNode: firstFocusNode,
                                controller: firstNameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  label: const Text('First name'),
                                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey[300]),
                                  floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                  contentPadding: const EdgeInsets.all(8),
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
                          const Gap(12),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: lastInputBorderColor,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8),
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
                                style: const TextStyle(fontSize: 16, color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  label: const Text('Last name'),
                                  labelStyle: TextStyle(fontSize: 16, color: Colors.grey[300]),
                                  floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                  contentPadding: const EdgeInsets.all(8),
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
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomFilledButton(
                      label: "Next",
                      onPressed: () => onSubmitPhone(context),
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
      ),
    );
  }
}