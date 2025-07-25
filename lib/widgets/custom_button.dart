import 'package:flutter/material.dart';

import 'package:expenz_app/constant/colors.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final Color btnColor;

  const CustomButton({
    super.key,
    required this.btnName,
    required this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: btnColor,
      ),
      child: Center(
        child: Text(
          btnName,
          style: TextStyle(
            fontSize: 17,
            color: kWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
