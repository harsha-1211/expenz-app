// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum IncomeCategory { Salary, Freelance, passive, Sales }

// category images
final Map<IncomeCategory, String> incomeCategoryImages ={
  IncomeCategory.Salary : "assets/images/salary.png",
  IncomeCategory.Freelance : "assets/images/freelance.png",
  IncomeCategory.passive : "assets/images/passive-income.png",
  IncomeCategory.Sales : "assets/images/sale.png",
};

// category Colors
final Map<IncomeCategory, Color> incomeCategoryColors ={
  IncomeCategory.Freelance: const Color(0xFFE57373),
  IncomeCategory.passive: const Color(0xFF81C784),
  IncomeCategory.Salary: const Color(0xFF64B5F6),
  IncomeCategory.Sales: const Color(0xFFFFD54F),
};

class IncomeModel {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  IncomeModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  //methods to convert to JSON obj(serialization)
  Map<String, dynamic> toJSON() {
    return {
      "Id": id,
      "Title": title,
      "Amount": amount,
      "Category": category.index,
      "Date": date.toIso8601String(),
      "Time": time.toIso8601String(),
      "Description": description,
    };
  }

  //methods to convert to dart obj(deserialization)
  factory IncomeModel.fromJSON(Map<String, dynamic> json) {
    return IncomeModel(
      id: json["Id"],
      title: json["Title"],
      amount: json["Amount"],
      category: IncomeCategory.values[json["Category"]],
      date: DateTime.parse(json["Date"]),
      time: DateTime.parse(json["Time"]),
      description: json["Description"],
    );
  }
}
