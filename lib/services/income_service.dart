import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:expenz_app/models/income_model.dart';

class IncomeService {
  //Income list
  List<IncomeModel> incomesList = [];

  //save Income key
  static const String _incomeKey = "Incomes";

  //save Incomes in shared preferenses
  Future<void> saveIncomes(IncomeModel income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      //convert the existing Incomes to a list of Income object
      List<IncomeModel> existingIncomesObject = [];

      if (existingIncomes != null) {
        existingIncomesObject = existingIncomes
            .map((e) => IncomeModel.fromJSON(json.decode(e)))
            .toList();
      }

      //add the new Incomes to the list
      existingIncomesObject.add(income);

      //convert the list of Incomes objects back to a list of strings
      List<String> updatedIncomes = existingIncomesObject
          .map((e) => json.encode(e.toJSON()))
          .toList();

      // save the updated list of Incomes in shared preferenses
      await prefs.setStringList(_incomeKey, updatedIncomes);

      //show massege
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income saved succesfully..."),
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

  //load the Incomes from shared preferenses
  Future<List<IncomeModel>> loadIncomes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingIncomes = prefs.getStringList(_incomeKey);

    //convert to existing Incomes to a list of Income objects
    List<IncomeModel> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes = existingIncomes
          .map((e) => IncomeModel.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedIncomes;
  }
}
