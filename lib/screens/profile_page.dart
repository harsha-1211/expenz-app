import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kWhite,
                  border: Border.all(
                    color: kMainColor,
                    width: 3,
                  )
                ),
              )
            ],
          ),

        ],
      )),
    );
  }
}