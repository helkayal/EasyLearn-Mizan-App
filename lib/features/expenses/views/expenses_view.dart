import 'package:flutter/material.dart';
import 'package:mizan_app/features/expenses/model/expenses_dm.dart';
import 'package:mizan_app/features/expenses/widgets/expense_card.dart';

class ExpensesView extends StatelessWidget {
  const ExpensesView({super.key, required this.salary});

  final double salary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: expensesList.length,
        itemBuilder: (context, index) {
          return ExpenseCard(expense: expensesList[index], salary: salary);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
      ),
    );
  }
}
