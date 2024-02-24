import 'package:client/utils/strings.dart';
import 'package:client/utils/styles.dart';
import 'package:client/utils/themes.dart';
import 'package:client/view_model/auth_viewmodel.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../utils/helper.dart';
import '../utils/scaler.dart';

class PhoneInputRegister extends StatefulWidget {
  final String name;
  final int optionVolunteer;

  const PhoneInputRegister({super.key, required this.name, required this.optionVolunteer});

  @override
  State<PhoneInputRegister> createState() => _PhoneInputRegisterState();
}

class _PhoneInputRegisterState extends State<PhoneInputRegister> {
  bool _validate = false;
  bool _isProcessing = false;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  Color inputBorderColor = Colors.grey[300]!;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          inputBorderColor = Colors.grey[700]!;
        });
      } else {
        setState(() {
          inputBorderColor = Colors.grey[300]!;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> onSubmitPhone(BuildContext context) async {
    setState(() {
      _isProcessing = true;
    });

    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    String phoneNumber = _phoneController.text.trim();
    phoneNumber = formatPhoneNumber(phoneNumber);

    bool userExists = await authViewModel.checkExistingUser(phoneNumber);
    if (!userExists) {
      setState(() {
        _validate = false;
      });
      authViewModel.signUpWithPhone(context, widget.name, widget.optionVolunteer, phoneNumber);
    }
    else {
      setState(() {
        _validate = true;
      });
      getErrorSnackBarNew('The account is already exists.');
    }

    setState(() {
      _isProcessing = false;
    });
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
                        MyStrings.phone_input_title,
                        style: TextStyle(
                            fontSize: 24 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            fontWeight: FontWeight.bold
                        )
                        ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, top: 5 * scaler.widthScaleFactor),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.phone_input_guide,
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
                    child: Container(
                      margin: EdgeInsets.all(16 * scaler.widthScaleFactor),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: inputBorderColor,
                          width: 1.0 * scaler.widthScaleFactor,
                        ),
                        borderRadius: BorderRadius.circular(8 * scaler.widthScaleFactor),
                      ),
                      child: TextFormField(
                        focusNode: _focusNode,
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length != 10) {
                            return 'Invalid phone number!';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 16 * scaler.widthScaleFactor, color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: const Text('Mobile Number'),
                          labelStyle: TextStyle(
                              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                              color: Colors.grey[300]
                          ),
                          floatingLabelStyle: TextStyle(
                              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
                              color: Colors.grey[700]
                          ),
                          contentPadding: EdgeInsets.all(12 * scaler.widthScaleFactor),
                          border: InputBorder.none,
                          errorText: _validate ? 'The account is already exists.' : null,
                        ),
                        keyboardType: TextInputType.phone,
                        // onChanged: (value) {
                        //   setState(() {
                        //     _validate = value.length != 10;
                        //   });
                        // },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor, top: 5 * scaler.widthScaleFactor),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.phone_input_sms_notice,
                        style: TextStyle(
                            fontSize: 14 * scaler.widthScaleFactor / scaler.textScaleFactor,
                            color: grey
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28 * scaler.widthScaleFactor),
                  Container(
                    margin: EdgeInsets.only(left: 16 * scaler.widthScaleFactor, right: 16 * scaler.widthScaleFactor),
                    child: CustomFilledButton(
                        label: "Next",
                        isLoading: _isProcessing,
                        onPressed: _isProcessing ? () {} : () {
                          _focusNode.unfocus();
                          _formKey.currentState!.validate()
                              ? onSubmitPhone(context)
                              : null;
                        }
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
                              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor ,
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