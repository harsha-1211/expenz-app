import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  //method to save the user name and e-mail in shared preferences
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
          SnackBar(content: Text("password and confirm password not match")),
        );
        return;
      }
      //user entered password and confirm password are equal
      //create an instance a shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the user name and email in key-value pairs
      await prefs.setString("UserName", userName);
      await prefs.setString("Email", email);
      await prefs.setString("Password", password);
      //show a msg to a user
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Your details stored sucsess")));
    } catch (err) {
      err.toString();
    }
  }

  //method to check is username saved in shared preferences??
  static Future<bool> isSavedUserName() async {
    //create an instance a shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("UserName");
    return userName != null;
  }

  //methods to a get username and email
  static Future<Map<String, String>> getUserData() async {
    //create an instance a shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = await prefs.getString("UserName");
    String? email = await prefs.getString("Email");
    return {"UserName": ?userName , "Email": ?email};
  }
}
