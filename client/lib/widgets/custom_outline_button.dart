import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 5,
          side: const BorderSide(color: Colors.deepOrangeAccent, width: 1.0),
          foregroundColor: Colors.deepOrangeAccent,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: MyStyles.tinyBoldTextStyle,
        ),
      ),
    );
  }
}