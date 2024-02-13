
import 'package:client/utils/strings.dart';
import 'package:client/utils/styles.dart';
import 'package:client/widgets/custom_filled_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class PhoneInputLogin extends StatefulWidget {
  const PhoneInputLogin({super.key});

  @override
  State<PhoneInputLogin> createState() => _PhoneInputLoginState();
}

class _PhoneInputLoginState extends State<PhoneInputLogin> {
  bool _validate = false;
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
    super.dispose();
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
      body: SafeArea(
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
                  padding: const EdgeInsets.only(left: 10, top: 15), // Ap dụng padding
                  child: Align(
                    alignment: Alignment.topLeft, // Căn chỉnh nút về phía góc trên bên trái
                    child: CupertinoNavigationBarBackButton(
                      color: Colors.black,
                    ),
                  ),
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 5), // Ap dụng padding
                  child: Align(
                    alignment: Alignment.topLeft, // Căn chỉnh nút về phía góc trên bên trái
                    child: Text(
                      MyStrings.phone_input_title,
                      style: MyStyles.headerTextStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 5), // Ap dụng padding
                  child: Align(
                    alignment: Alignment.topLeft, // Căn chỉnh nút về phía góc trên bên trái
                    child: Text(
                      MyStrings.phone_input_guide,
                      style: MyStyles.blackTinyTextStyle,
                    ),
                  ),
                ),
                Gap(10),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
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
                        return null;
                      },
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        label: const Text('Mobile Number'),
                        labelStyle: TextStyle(fontSize: 16, color: Colors.grey[300]),
                        floatingLabelStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        contentPadding: const EdgeInsets.all(12),
                        border: InputBorder.none,
                        errorText: _validate ? 'Invalid phone number!' : null,
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
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 5), // Ap dụng padding
                  child: Align(
                    alignment: Alignment.topLeft, // Căn chỉnh nút về phía góc trên bên trái
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
                    onPressed: () {},
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