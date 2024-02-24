import 'package:client/ui/pin_authen_login_screen.dart';
import 'package:client/utils/strings.dart';
import 'package:client/utils/styles.dart';
import 'package:client/utils/themes.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../utils/helper.dart';
import '../view_model/auth_viewmodel.dart';

class PhoneInputLogin extends StatefulWidget {
  const PhoneInputLogin({super.key});

  @override
  State<PhoneInputLogin> createState() => _PhoneInputLoginState();
}

class _PhoneInputLoginState extends State<PhoneInputLogin> {
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
    if (userExists) {
      setState(() {
        _validate = false;
      });
      authViewModel.signInWithPhone(context, phoneNumber);
    }
    else {
      setState(() {
        _validate = true; // Đảm bảo bạn cập nhật UI để phản ánh trạng thái này
      });
      getErrorSnackBarNew('The account is not exists.');
    }

    setState(() {
      _isProcessing = false;
    });
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
                        MyStrings.phone_input_title,
                        style: MyStyles.headerTextStyle,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.phone_input_guide,
                        style: MyStyles.blackTinyTextStyle,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: inputBorderColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
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
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: const Text('Mobile Number'),
                          labelStyle: TextStyle(fontSize: 16, color: Colors.grey[300]),
                          floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          contentPadding: const EdgeInsets.all(12),
                          border: InputBorder.none,
                          errorText: _validate ? 'The account is not exists.' : null,
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
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 5),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        MyStrings.phone_input_sms_notice,
                        style: MyStyles.moreTinyTextStyle,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomFilledButton(
                      label: "Next",
                      isLoading: _isProcessing,
                      onPressed: _isProcessing ? () {} : () {
                        _focusNode.unfocus();
                        _formKey.currentState!.validate()
                        ? onSubmitPhone(context)
                        : null;
                      },
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
                          MyStrings.create_account,
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