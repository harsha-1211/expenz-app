import 'package:expenz_app/constant/colors.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final Color categoryColor;
  final String title;
  final double amount;
  final double total;
  final bool isExpense;

  const CategoryCard({
    super.key,
    required this.categoryColor,
    required this.title,
    required this.amount,
    required this.total,
    required this.isExpense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    double progressWidth = (widget.total) != 0
        ? MediaQuery.of(context).size.width * (widget.amount / widget.total)
        : 0;

    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 5),
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [BoxShadow(blurRadius: 2, color: kGrey)],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: widget.categoryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: kBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "\$ ${(widget.amount).toStringAsFixed(2)}",
                  style: TextStyle(
                    color: widget.isExpense ? kRed : kGreen,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              height: 12,
              width: progressWidth,
              decoration: BoxDecoration(
                color: widget.categoryColor,
                borderRadius: BorderRadius.circular(30)
              ),
            )
          ],
        ),
      ),
    );
  }
}
