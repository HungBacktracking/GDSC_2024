import 'package:flutter/material.dart';

import '../utils/themes.dart';

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
   return Container(
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
     child: Padding(
       padding: const EdgeInsets.only(left: 15.0),
       child: Row(
         children: [
           Image.asset(assetUrl),
           Padding(
             padding: const EdgeInsets.only(top: 15.0, left: 15.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   tittle,
                   textAlign: TextAlign.left,
                   style: TextStyle(
                     fontSize: 20,
                     color: textColor,
                     fontWeight: FontWeight.w600
                   ),
                 ),
                 Text(
                   subTittle,
                   textAlign: TextAlign.left,
                   style: TextStyle(
                       fontSize: 15,
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