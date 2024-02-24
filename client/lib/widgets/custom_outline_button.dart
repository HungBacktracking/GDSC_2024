import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/scaler.dart';
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
    Scaler().init(context);
    final scaler = Scaler();
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          elevation: 5 * scaler.widthScaleFactor,
          side: BorderSide(color: Colors.deepOrangeAccent, width: 1.0 * scaler.widthScaleFactor),
          foregroundColor: Colors.deepOrangeAccent,
          padding: EdgeInsets.symmetric(vertical: 12 * scaler.widthScaleFactor),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 16 * scaler.widthScaleFactor / scaler.textScaleFactor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}