// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum ExpenseCategory { Shopping, Subscriptions, Food, Health, Transport }

// category images
final Map<ExpenseCategory, String> expenseCategoryImages = {
  ExpenseCategory.Shopping: "assets/images/bag.png",
  ExpenseCategory.Subscriptions: "assets/images/bill.png",
  ExpenseCategory.Food: "assets/images/restaurant.png",
  ExpenseCategory.Health: "assets/images/health.png",
  ExpenseCategory.Transport: "assets/images/car.png",
};

// category Colors
final Map<ExpenseCategory, Color> expenseCategoryColors = {
  ExpenseCategory.Food: const Color(0xFFE57373),
  ExpenseCategory.Transport: const Color(0xFF81C784),
  ExpenseCategory.Health: const Color(0xFF64B5F6),
  ExpenseCategory.Shopping: const Color(0xFFFFD54F),
  ExpenseCategory.Subscriptions: const Color(0xFF9575CD),
};

class ExpenseModel {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  ExpenseModel({
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
  factory ExpenseModel.fromJSON(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json["Id"],
      title: json["Title"],
      amount: json["Amount"],
      category: ExpenseCategory.values[json["Category"]],
      date: DateTime.parse(json["Date"]),
      time: DateTime.parse(json["Time"]),
      description: json["Description"],
    );
  }
}
