import 'package:flutter/material.dart';

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
      theme: ThemeData(fontFamily: "Inter"),
      home: Scaffold(
        body: Center(
          child: Text(
            "Hello Friends !!!!!",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
