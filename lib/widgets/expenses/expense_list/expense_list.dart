import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_list/expense_card.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenseItemsList,
    required this.removeExpense,
  });

  final List<Expense> expenseItemsList;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenseItemsList[index]),
        background: Card(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          child: Center(
            child: Text(
              "Delete",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ),
        onDismissed: (direction) {
          removeExpense(expenseItemsList[index]);
        },
        child: ExpenseCard(
          expense: expenseItemsList[index],
        ),
      ),
      itemCount: expenseItemsList.length,
    );
  }
}
