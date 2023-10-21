import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMMMd();

class CreateExpense extends StatefulWidget {
  const CreateExpense({super.key, required this.addExpense});

  final void Function(Expense expense) addExpense;

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _datePicked;
  Category _pickedCategory = Category.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  _displayDatePicker() async {
    final datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime.now(),
    );
    if (datePicked != null) {
      setState(() {
        _datePicked = datePicked;
      });
    }
  }

  _handleSelectCategory(Category? value) {
    if (value != null) {
      setState(() {
        _pickedCategory = value;
      });
    }
  }

  _handleCancel() {
    Navigator.pop(context);
  }

  _handleSave() {
    if (!_validateExpenseData()) {
      showCupertinoDialog(
        context: context,
        builder: (dialogContext) => CupertinoAlertDialog(
          title: const Text("Invalid data entered"),
          content: const Text(
              "Please check the data entered for title, date, category and amount..."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
      return;
    }
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    final category = _pickedCategory;
    final datetime = _datePicked;
    final expense = Expense(
        title: title, amount: amount!, dateTime: datetime!, category: category);
    widget.addExpense(expense);
    Navigator.pop(context);
  }

  _validateExpenseData() {
    final amount = double.tryParse(_amountController.text);
    final isAmountInvalid = amount == null || amount < 0;
    if (_titleController.text.trim().isEmpty ||
        isAmountInvalid ||
        _datePicked == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$",
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _datePicked != null
                            ? dateFormatter.format(_datePicked!)
                            : "No Date Selected",
                      ),
                    ),
                    IconButton(
                      onPressed: _displayDatePicker,
                      icon: const Icon(
                        Icons.date_range,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButton(
                  value: _pickedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                categoryIcons[category],
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                category.name.toUpperCase(),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: _handleSelectCategory,
                ),
              ),
              TextButton(
                onPressed: _handleCancel,
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _handleSave,
                child: const Text("Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
