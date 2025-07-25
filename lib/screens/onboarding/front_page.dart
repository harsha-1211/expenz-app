import 'package:flutter/material.dart';

import 'package:expenz_app/constant/colors.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png", width: 150, fit: BoxFit.cover,),
        Text("Expenz", style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w900,
          color: kMainColor,
        ),)
      ],
    );
  }
}