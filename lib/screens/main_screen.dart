import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_page.dart';
import 'package:expenz_app/screens/home_page.dart';
import 'package:expenz_app/screens/profile_page.dart';
import 'package:expenz_app/screens/transaction_page.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      HomePage(),
      TransactionPage(),
      AddNewScreen(),
      BudgetPage(),
      ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kLightGrey,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows_outlined),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.add_rounded, color: kWhite, size: 35),
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_rounded),
            label: "Budget",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
