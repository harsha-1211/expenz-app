import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  final List<ExpenseModel> expensesList;
  final List<IncomeModel> incomeList;
  final void Function(ExpenseModel) ondismissedExpense;
  final void Function(IncomeModel) ondismissedIncome;

  const TransactionPage({
    super.key,
    required this.expensesList,
    required this.incomeList,
    required this.ondismissedExpense,
    required this.ondismissedIncome,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "See your financial report",
                style: TextStyle(
                  fontSize: 22,
                  color: kMainColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 20,
                  color: kBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
                child: SingleChildScrollView(
                  child: widget.expensesList.isEmpty
                      ? Text(
                          "No expenses added yet, add some expenses to see here",
                          style: TextStyle(fontSize: 16, color: kGrey),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: widget.expensesList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final expense = widget.expensesList[index];
                            return Dismissible(
                              onDismissed: (direction) {
                                setState(() {
                                  widget.ondismissedExpense(expense);
                                });
                              },
                              key: ValueKey(expense),
                              child: ExpenceCard(
                                title: expense.title,
                                date: expense.date,
                                amount: expense.amount,
                                category: expense.category,
                                description: expense.description,
                              ),
                            );
                          },
                        ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Incomes",
                style: TextStyle(
                  fontSize: 20,
                  color: kBlack,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.32,
                child: SingleChildScrollView(
                  child: widget.incomeList.isEmpty
                      ? Text(
                          "No Incomes added yet, add some Incomes to see here",
                          style: TextStyle(fontSize: 16, color: kGrey),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.incomeList.length,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final income = widget.incomeList[index];
                            return Dismissible(
                              onDismissed: (direction) {
                                setState(() {
                                  widget.ondismissedIncome(income);
                                });
                              },
                              key: ValueKey(income),
                              direction: DismissDirection.startToEnd,
                              child: IncomeCard(
                                title: income.title,
                                date: income.date,
                                amount: income.amount,
                                category: income.category,
                                description: income.description,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
