import 'package:flutter/material.dart';

class ExpensesDM {
  final String titleKey;
  final double percentage;
  final List<ExpenseCategoryDM> categories;

  const ExpensesDM({
    required this.titleKey,
    required this.percentage,
    required this.categories,
  });
}

class ExpenseCategoryDM {
  final String key; // localization key
  final IconData icon;

  const ExpenseCategoryDM({required this.key, required this.icon});
}

final List<ExpensesDM> expensesList = [
  ExpensesDM(
    titleKey: 'fixed_expenses_title',
    percentage: 0.5,
    categories: const [
      ExpenseCategoryDM(
        key: 'category_electricity_water',
        icon: Icons.electric_bolt,
      ),
      ExpenseCategoryDM(key: 'category_education', icon: Icons.school),
      ExpenseCategoryDM(key: 'category_healthcare', icon: Icons.local_hospital),
      ExpenseCategoryDM(
        key: 'category_transportation',
        icon: Icons.directions_bus,
      ),
      ExpenseCategoryDM(key: 'category_communications', icon: Icons.phone),
    ],
  ),
  ExpensesDM(
    titleKey: 'variable_expenses_title',
    percentage: 0.3,
    categories: const [
      ExpenseCategoryDM(key: 'category_shopping', icon: Icons.shopping_cart),
      ExpenseCategoryDM(key: 'category_entertainment', icon: Icons.movie),
      ExpenseCategoryDM(key: 'category_trips', icon: Icons.flight),
      ExpenseCategoryDM(key: 'category_gifts', icon: Icons.card_giftcard),
    ],
  ),
  ExpensesDM(
    titleKey: 'savings_title',
    percentage: 0.2,
    categories: const [
      ExpenseCategoryDM(key: 'category_increase_savings', icon: Icons.savings),
      ExpenseCategoryDM(key: 'category_debt_payment', icon: Icons.payments),
      ExpenseCategoryDM(key: 'category_emergency', icon: Icons.warning_amber),
    ],
  ),
];
