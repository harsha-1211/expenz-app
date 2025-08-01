import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //method to savethe user name and e-mail in shared preferences
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      //check the user entered password and confirmpassword are not-equal
      if (password != confirmPassword) {
        //show a msg to a User
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("password and confirm password not equal")),
        );
        return;
      }
      //user entered password and confirmpassword are equal
      //create and instance a shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email in key-value pairs
      await prefs.setString("UserName", userName);
      await prefs.setString("Email", email);
      //show a msg to a user
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your details stored sucsess")));
    } catch (err) {
      err.toString();
    }
  }
}
