import 'package:expense_tracker/models/Bucket.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final Bucket bucket;
  final double fill;

  const ChartBar({super.key, required this.bucket, required this.fill});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: FractionallySizedBox(
              heightFactor: fill,
              widthFactor: 0.5,
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Icon(
            categoryIcons[bucket.category],
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }
}
