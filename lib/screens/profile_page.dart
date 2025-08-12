import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/screens/onboarding_screen.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user name
  String username = '';
  //email
  String email = '';

  @override
  void initState() {
    //get user name
    UserService.getUserData().then((value) {
      if (value["UserName"] != null) {
        username = value["UserName"]!;
      }
    });
    //get email
    UserService.getUserData().then((value) {
      if (value["Email"] != null) {
        email = value["Email"]!;
      }
    });
    super.initState();
  }

  //open scaffold messenger for logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.indigo[200],
      context: context,
      builder: (context) {
        return Container(
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Logout?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Are you sure do you wanna logout ?",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: kMainColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(kMainColor),
                        ),
                        onPressed: () async {
                          //clear data
                          await UserService.removeUserData();
                          if (context.mounted) {
                            await IncomeService().removeAllIncomes(context);
                            await ExpenseService().removeAllExpenses(context);
                          }

                          //navigate to the onboarding screen
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingScreen(),
                            ),
                            (route) => false,
                          );
                          
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: kWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 3, color: kMainColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset("assets/images/user.jpg"),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              username,
                              style: TextStyle(
                                fontSize: 30,
                                color: kBlack,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.edit_outlined, size: 40),
                ],
              ),
              SizedBox(height: 30),
              ProfileCard(
                color: kMainColor,
                title: 'My Wallet',
                icon: Icons.account_balance_wallet_rounded,
              ),
              ProfileCard(
                color: kMainColor,
                title: 'Settings',
                icon: Icons.settings,
              ),
              ProfileCard(
                color: kMainColor,
                title: 'Export Data',
                icon: Icons.upload_rounded,
              ),
              GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: ProfileCard(
                  color: kRed,
                  title: 'Logout',
                  icon: Icons.logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
