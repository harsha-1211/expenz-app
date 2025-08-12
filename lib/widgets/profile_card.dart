import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  const ProfileCard({super.key, required this.color, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width* 0.7,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [BoxShadow(blurRadius: 3, color: kLightGrey)],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, size: 30, color: color,),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                color: kBlack,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
