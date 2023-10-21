import 'package:expense_tracker/models/Bucket.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  Chart({super.key, required this.expenses})
      : buckets = Category.values
            .map((e) => Bucket.from(category: e, expensesList: expenses))
            .toList(),
        total = expenses
            .map((e) => e.amount)
            .reduce((value, element) => value + element);

  final List<Expense> expenses;
  final List<Bucket> buckets;
  final double total;

  @override
  Widget build(BuildContext context) {
    final fill =
        buckets.map((e) => e.totalExpense).map((e) => e / total).toList();
    final horizontalMargin =
        Theme.of(context).cardTheme.margin?.horizontal ?? 16;
    final verticalMargin = Theme.of(context).cardTheme.margin?.vertical ?? 8;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var i = 0; i < buckets.length; i++)
                ChartBar(
                  bucket: buckets[i],
                  fill: fill[i],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
