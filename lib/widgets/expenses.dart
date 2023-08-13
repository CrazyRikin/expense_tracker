import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses-list/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses-list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});

  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  final List<Expense> _reqisteredexpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 500,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Movie',
        amount: 300,
        date: DateTime.now(),
        category: Category.lesiure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(addExpense));
  }

  void addExpense(Expense expense) {
    setState(() {
      _reqisteredexpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _reqisteredexpenses.indexOf(expense);
    setState(() {
      _reqisteredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense Deleted!'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              _reqisteredexpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No Expenses Found! Try adding some new!'),
    );
    if (_reqisteredexpenses.isNotEmpty) {
      mainContent = ExpensesList(
        deleteData: removeExpense,
        expenses: _reqisteredexpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Expense Tracker'), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _reqisteredexpenses),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _reqisteredexpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
