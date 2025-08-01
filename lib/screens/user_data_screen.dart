import 'package:expenz_app/services/user_service.dart';
import 'package:flutter/material.dart';

import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/screens/main_screen.dart';
import 'package:expenz_app/widgets/custom_button.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  //for the check box
  bool _isRemember = false;

  //form key for the form validation
  final _formKey = GlobalKey<FormState>();

  //controlers for the text from feilds
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your \nPersonal Details",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 40),

                //form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form feild for user name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          //validation
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                            color: kGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            borderSide: BorderSide(color: kGrey, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      //form feild for e-mail
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          //validation
                          if (value!.isEmpty) {
                            return "Please Enter Your E-mail";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                            color: kGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            borderSide: BorderSide(color: kGrey, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      //form feild for password
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          //validation
                          if (value!.isEmpty) {
                            return "Please Enter a Valid Pasword";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                            color: kGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            borderSide: BorderSide(color: kGrey, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      //form feild for confirm password
                      TextFormField(
                        controller: _confirmPasswordController,
                        validator: (value) {
                          //validation
                          if (value!.isEmpty) {
                            return "Please Enter a Valid Confirmation Password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Pasword",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 17,
                            color: kGrey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              kDefaultPadding,
                            ),
                            borderSide: BorderSide(color: kGrey, width: 5),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      //Remember Me for the next time
                      Row(
                        children: [
                          Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Checkbox(
                              activeColor: kMainColor,
                              hoverColor: kGrey,
                              value: _isRemember,
                              onChanged: (value) {
                                setState(() {
                                  _isRemember = !_isRemember;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      //submit button
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            //from is valid, process data
                            String username = _userNameController.text;
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            String confirmPassword =
                                _confirmPasswordController.text;

                            //save data in local device storeage
                            await UserService.storeUserDetails(
                              userName: username,
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                              context: context,
                            );
                            if (context.mounted) {
                              //navigate to main page
                              if (password == confirmPassword) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: CustomButton(
                          btnName: "Next",
                          btnColor: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
