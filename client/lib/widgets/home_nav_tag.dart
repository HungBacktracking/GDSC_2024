import 'package:flutter/material.dart';

import '../utils/scaler.dart';

class HomeNavigationTag extends StatelessWidget {
  const HomeNavigationTag({
    super.key,
    required this.assetUrl,
    required this.tittle,
    required this.subTittle,
    required this.textColor,
  });

  final String assetUrl;
  final String tittle;
  final String subTittle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
   Scaler().init(context); // Add this line (context is the BuildContext passed to this build method
   Scaler scaler = Scaler();
   return Container(
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15 * scaler.widthScaleFactor),
        ),
     child: Padding(
       padding: EdgeInsets.only(left: 15.0 * scaler.widthScaleFactor),
       child: Row(
         children: [
           Image.asset(assetUrl),
           Padding(
             padding: EdgeInsets.only(top: 15.0 * scaler.widthScaleFactor, left: 15.0 * scaler.widthScaleFactor),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   tittle,
                   textAlign: TextAlign.left,
                   style: TextStyle(
                     fontSize: 20 * scaler.widthScaleFactor / scaler.textScaleFactor,
                     color: textColor,
                     fontWeight: FontWeight.w600
                   ),
                 ),
                 Text(
                   subTittle,
                   textAlign: TextAlign.left,
                   style: TextStyle(
                       fontSize: 15 * scaler.widthScaleFactor/ scaler.textScaleFactor,
                       color: textColor,
                       fontWeight: FontWeight.w500
                   ),
                 )
               ],
             ),
           )
         ],
       ),
     ),
   );
  }
}