import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';
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
    Scaler().init(context);
    final scaler = Scaler();

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: widget.onPressed,
        style: FilledButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.deepOrangeAccent,
          padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
        ),
        child: widget.isLoading
        ? SizedBox(
          height: 20 * scaler.widthScaleFactor,
          width: 20 * scaler.widthScaleFactor,
          child: CircularProgressIndicator(
            strokeWidth: 2 * scaler.widthScaleFactor,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
        : Text(
          widget.label,
          style: TextStyle(
              fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}