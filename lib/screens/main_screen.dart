import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_service.dart';
import 'package:flutter/material.dart';

import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_page.dart';
import 'package:expenz_app/screens/home_page.dart';
import 'package:expenz_app/screens/profile_page.dart';
import 'package:expenz_app/screens/transaction_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentIndex = 0;

  List<ExpenseModel> expenseList = [];
  List<IncomeModel> incomeList = [];

  //funtion to flech expenses
  void flechAllExpenses() async {
    List<ExpenseModel> loadedExpenses = await ExpenseService().loadExpenses();

    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //funtion to flech expenses
  void flechAllIncomes() async {
    List<IncomeModel> loadedIncomes = await IncomeService().loadIncomes();

    setState(() {
      incomeList = loadedIncomes;
    });
  }

  //funtion to add a new expense
  void addNewExpense(ExpenseModel newExpense) {
    ExpenseService().saveExpenses(newExpense, context);

    //update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  //funtion to add a new Income
  void addNewIncome(IncomeModel newIncome) {
    IncomeService().saveIncomes(newIncome, context);

    //update the list of Incomes
    setState(() {
      incomeList.add(newIncome);
    });
  }

  //function to remove expense
  void removeExpense(ExpenseModel expense) {
    ExpenseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  //function to remove Income
  void removeIncome(IncomeModel income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //function to cal total expense
  Map<ExpenseCategory, double> calExpenseCategoryTotal() {
    Map<ExpenseCategory, double> categoryTotals = {
      ExpenseCategory.Food: 0,
      ExpenseCategory.Health: 0,
      ExpenseCategory.Shopping: 0,
      ExpenseCategory.Subscriptions: 0,
      ExpenseCategory.Transport: 0,
    };

    for (ExpenseModel expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }
    return categoryTotals;
  }

  //function to cal total Income
  Map<IncomeCategory, double> calIncomeCategoryTotal() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.Freelance: 0,
      IncomeCategory.Salary: 0,
      IncomeCategory.Sales: 0,
      IncomeCategory.passive: 0,
    };

    for (IncomeModel income in incomeList) {
      categoryTotals[income.category] =
          (categoryTotals[income.category]! + income.amount);
    }
    return categoryTotals;
  }

  @override
  void initState() {
    setState(() {
      flechAllExpenses();
      flechAllIncomes();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //screen list
    final List<Widget> pages = [
      HomePage(expensesList: expenseList, incomeList: incomeList),
      TransactionPage(
        expensesList: expenseList,
        incomeList: incomeList,
        ondismissedExpense: removeExpense,
        ondismissedIncome: removeIncome,
      ),
      AddNewScreen(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetPage(
        expenseCategoryTotals: calExpenseCategoryTotal(),
        incomeCategoryTotals: calIncomeCategoryTotal(),
      ),
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
