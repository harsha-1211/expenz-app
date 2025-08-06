import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenz_app/models/expense_model.dart';

class ExpenseService {
  //expense list
  List<ExpenseModel> expensesList = [];

  //save expense key
  static const String _expenseKey = "expenses";

  //save expenses in shared preferenses
  Future<void> saveExpenses(ExpenseModel expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      //convert the existing expenses to a list of expense object
      List<ExpenseModel> existingExpensesObject = [];

      if (existingExpenses != null) {
        existingExpensesObject = existingExpenses
            .map((e) => ExpenseModel.fromJSON(json.decode(e)))
            .toList();
      }

      //add the new expenses to the list
      existingExpensesObject.add(expense);

      //convert the list of expenses objects back to a list of strings
      List<String> updatedExpenses = existingExpensesObject
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save the updated list of expenses in shared preferenses
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show massege
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense saved succesfully..."),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (err) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Having Error : $err"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load the expenses from shared preferenses
  Future<List<ExpenseModel>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    //convert to existing expenses to a list of expense objects
    List<ExpenseModel> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => ExpenseModel.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }
}
