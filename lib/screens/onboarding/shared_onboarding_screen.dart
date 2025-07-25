import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const SharedOnboardingScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageUrl, width: 250, fit: BoxFit.cover),
          Text(
            title,
            style: TextStyle(
              color: kBlack,
              fontSize: 35,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: kGrey,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
