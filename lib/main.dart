import 'package:flutter/material.dart';

import 'package:expenz_app/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "expenz app",
      theme: ThemeData(fontFamily: 'Inter'),
      home: OnboardingScreen(),
    );
  }
}
