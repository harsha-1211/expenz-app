import 'package:flutter/material.dart';

import 'package:expenz_app/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
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
