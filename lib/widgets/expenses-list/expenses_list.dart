import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses-list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.deleteData, required this.expenses, super.key});
  final List<Expense> expenses;
  final void Function(Expense expense) deleteData;
  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: ((ctx, index) => Dismissible(
            background: Container(
                margin: Theme.of(context).cardTheme.margin,
                color: Theme.of(context).colorScheme.error.withOpacity(0.2)),
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              deleteData(expenses[index]);
            },
            child: ExpensesItem(
              expenses[index],
            ),
          )),
    );
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> alExpenses, this.category)
      : expenses = alExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
