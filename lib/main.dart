import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.isSavedUserName(),
      builder: (context, snapshot) {
        //if snapshot still waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: kMainColor);
        } else {
          //here the has userName will beset to true of the data is their in the snapshot and other wise false
          bool hasUserName = snapshot.data ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "expenz app",
            theme: ThemeData(fontFamily: "Inter"),
            home: Wrapper(showMainScreen: hasUserName,),
          );
          
        }
      },
    );
  }
}
