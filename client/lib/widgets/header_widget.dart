import 'package:client/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../utils/strings.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/logo.png'),
        const Gap(20),
        const Text(
          Strings.header_text,
          style: MyStyles.headerTextStyle,
        ),
      ],
    );
  }
}