import 'package:flutter/material.dart';

import 'package:expenz_app/screens/main_screen.dart';
import 'package:expenz_app/screens/onboarding_screen.dart';

class Wrapper extends StatefulWidget {
  final bool showMainScreen;
  const Wrapper({super.key, required this.showMainScreen});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.showMainScreen ? MainScreen() : OnboardingScreen();
  }
}
