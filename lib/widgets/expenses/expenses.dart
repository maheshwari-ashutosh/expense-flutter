import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/test_data/expenses.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/create_expense.dart';
import 'package:expense_tracker/widgets/expenses/expense_list/expense_list.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({
    super.key,
  });

  final expensesList = expenses;

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  _showCreateExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (modalContext) => Padding(
        padding: const EdgeInsets.all(16),
        child: CreateExpense(
          addExpense: _addExpense,
        ),
      ),
    );
  }

  _addExpense(Expense expense) {
    setState(() {
      widget.expensesList.add(expense);
    });
  }

  _removeExpense(Expense expense) {
    final expenseIndex = widget.expensesList.indexOf(expense);
    if (expenseIndex == -1) return;
    setState(() {
      widget.expensesList.remove(expense);
    });
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        content: const Text("Expense deleted!"),
        duration: const Duration(seconds: 10),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              widget.expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
            "No Expenses to show here! Please add Expense by clicking '+' button on bottom right!"),
      ),
    );

    if (widget.expensesList.isNotEmpty) {
      mainContent = Column(
        children: [
          Chart(expenses: widget.expensesList),
          Expanded(
            child: ExpenseList(
              expenseItemsList: widget.expensesList,
              removeExpense: _removeExpense,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      drawer: const Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateExpenseModal,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Expenses"),
      ),
      body: mainContent,
    );
  }
}
