import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expense_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  final bool isExpense;

  const PieChartWidget({
    super.key,
    required this.expenseCategoryTotals,
    required this.incomeCategoryTotals,
    required this.isExpense,
  });

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  //sections data
  List<PieChartSectionData> getCharts() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.Food],
          value: widget.expenseCategoryTotals[ExpenseCategory.Food],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.Health],
          value: widget.expenseCategoryTotals[ExpenseCategory.Health],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.Shopping],
          value: widget.expenseCategoryTotals[ExpenseCategory.Shopping],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.Subscriptions],
          value: widget.expenseCategoryTotals[ExpenseCategory.Subscriptions],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: expenseCategoryColors[ExpenseCategory.Transport],
          value: widget.expenseCategoryTotals[ExpenseCategory.Transport],
          showTitle: false,
          radius: 40,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.Freelance],
          value: widget.incomeCategoryTotals[IncomeCategory.Freelance],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.Salary],
          value: widget.incomeCategoryTotals[IncomeCategory.Salary],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.Sales],
          value: widget.incomeCategoryTotals[IncomeCategory.Sales],
          showTitle: false,
          radius: 40,
        ),
        PieChartSectionData(
          color: incomeCategoryColors[IncomeCategory.passive],
          value: widget.incomeCategoryTotals[IncomeCategory.passive],
          showTitle: false,
          radius: 40,
        ),
      ];
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -60,
      sections: getCharts(),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$" ,
                style: TextStyle(
                  fontSize: 60,
                  color: widget.isExpense ? kRed : kGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
