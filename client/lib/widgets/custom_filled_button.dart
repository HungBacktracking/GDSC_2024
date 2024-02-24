import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomFilledButton extends StatefulWidget {
  const CustomFilledButton ({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  State<CustomFilledButton> createState() => CustomFilledButtonState();
}

class CustomFilledButtonState extends State<CustomFilledButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: widget.onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.deepOrangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: widget.isLoading
        ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
        : Text(
          widget.label,
          style: MyStyles.tinyBoldTextStyle,
        ),
      ),
    );
  }
}