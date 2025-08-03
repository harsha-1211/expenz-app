// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

enum IncomeCategory { Salary, Freelance, PassiveIncome, Sales }

// category images
final Map<IncomeCategory, String> incomeCategoryImages ={
  IncomeCategory.Salary : "assets/images/salary.png",
  IncomeCategory.Freelance : "assets/images/freelance.png",
  IncomeCategory.PassiveIncome : "assets/images/passive-income.png",
  IncomeCategory.Sales : "assets/images/sale.png",
};

// category Colors
final Map<IncomeCategory, Color> incomeCategoryColors ={
  IncomeCategory.Freelance: const Color(0xFFE57373),
  IncomeCategory.PassiveIncome: const Color(0xFF81C784),
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
}
