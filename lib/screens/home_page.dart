import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_expence_card.dart';
import 'package:expenz_app/widgets/line_chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/services/user_service.dart';

class HomePage extends StatefulWidget {
  final List<ExpenseModel> expensesList;
  final List<IncomeModel> incomeList;

  const HomePage({
    super.key,
    required this.expensesList,
    required this.incomeList,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for store the username
  String userName = "";
  //total income
  double totalIncome = 0;
  //total expense
  double totalExpense = 0;

  @override
  void initState() {
    //get a username from shared preferences
    UserService.getUserData().then((value) {
      if (value["UserName"] != null) {
        userName = value["UserName"]!;
      }
    });
    setState(() {
      //total amount of income
      for (var i = 0; i < widget.incomeList.length; i++) {
        totalIncome += widget.incomeList[i].amount;
      }
      //total amount of expense
      for (var i = 0; i < widget.expensesList.length; i++) {
        totalExpense += widget.expensesList[i].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: kMainColor.withOpacity(0.37),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kWhite,
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  100,
                                ),
                                child: Image.asset("assets/images/user.jpg"),
                              ),
                            ),
                          ),
                          Text(
                            "Welcome $userName",
                            style: TextStyle(
                              color: kBlack,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: totalIncome,
                            imageUrl: "assets/images/income.png",
                            cardBGColor: kGreen,
                          ),
                          IncomeExpenceCard(
                            title: "Expenses",
                            amount: totalExpense,
                            imageUrl: "assets/images/expense.png",
                            cardBGColor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5),
                    //line chart
                    LineChartWidget(),

                    SizedBox(height: 10),
                    Text(
                      "Recent Transaction",
                      style: TextStyle(
                        color: kBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
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
                                return ExpenceCard(
                                  title: expense.title,
                                  date: expense.date,
                                  amount: expense.amount,
                                  category: expense.category,
                                  description: expense.description,
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
