import 'package:client/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/scaler.dart';
import '../utils/strings.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Scaler().init(context);
    Scaler scaler = Scaler();
    return Row(
      children: [
        Image.asset('assets/images/logo.png', width: 50 * scaler.widthScaleFactor, height: 45 * scaler.heightScaleFactor,),
        Gap(20 * scaler.widthScaleFactor),
        Text(
          MyStrings.header_text,
          style: TextStyle(
              fontSize: 24 * scaler.widthScaleFactor / scaler.textScaleFactor,
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}