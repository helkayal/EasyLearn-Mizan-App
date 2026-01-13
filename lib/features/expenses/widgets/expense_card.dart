import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/features/expenses/model/expenses_dm.dart';
import 'package:mizan_app/features/expenses/widgets/percentage_circle.dart';

class ExpenseCard extends StatelessWidget {
  final ExpensesDM expense;
  final double salary;

  const ExpenseCard({super.key, required this.expense, required this.salary});

  double get calculatedAmount => salary * expense.percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.onSecondary,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "expenses.${expense.titleKey}".tr(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: PercentageCircle(
              percentage: expense.percentage,
              amount: calculatedAmount,
            ),
          ),
          const SizedBox(height: 16),
          ...expense.categories.map(
            (category) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    category.icon,
                    size: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "expenses.${category.key}".tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
