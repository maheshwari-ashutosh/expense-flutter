import 'package:expense_tracker/models/expense.dart';

class Bucket {
  Bucket({
    required this.category,
    required this.expenses,
  });

  Bucket.from({required this.category, required List<Expense> expensesList})
      : expenses = expensesList
            .where((element) => element.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    if (expenses.isEmpty) return 0;
    return expenses
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
  }

  get icon {
    return categoryIcons[category];
  }
}
