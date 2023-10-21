import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category { leisure, travel, work, food }

final dateFormatter = DateFormat.yMMMMd();

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.dateTime,
      required this.category})
      : id = Random().toString();

  get formattedDateTime {
    return dateFormatter.format(dateTime);
  }
}
