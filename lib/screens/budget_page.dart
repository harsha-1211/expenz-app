import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/widgets/category_card.dart';
import 'package:expenz_app/widgets/pie_chart_widget.dart';
import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;

  const BudgetPage({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int _selectedMethod = 0;

  //category color find method
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedMethod == 0
        ? widget.expenseCategoryTotals
        : widget.incomeCategoryTotals;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Financial Report",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: kBlack,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: kGrey,
                        offset: Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                    color: kLightGrey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 0;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethod == 0
                                ? kMainColor
                                : kLightGrey,
                          ),
                          child: Center(
                            child: Text(
                              "Expense",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedMethod == 0 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = 1;
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.44,
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: _selectedMethod == 1
                                ? kMainColor
                                : kLightGrey,
                          ),
                          child: Center(
                            child: Text(
                              "Income",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _selectedMethod == 1 ? kWhite : kBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //pie chart
              PieChartWidget(
                expenseCategoryTotals: widget.expenseCategoryTotals,
                incomeCategoryTotals: widget.incomeCategoryTotals,
                isExpense: _selectedMethod == 0,
              ),
              SizedBox(height: 20),
              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final category = data.keys.toList()[index];
                      final amount = data.values.toList()[index];
                      return CategoryCard(
                        categoryColor: getCategoryColor(category),
                        title: category.name,
                        amount: amount,
                        total: data.values.reduce(
                          (value, element) => value + element,
                        ),
                        isExpense: _selectedMethod == 0,
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
