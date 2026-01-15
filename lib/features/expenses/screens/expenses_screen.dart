import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/core/widgets/welcome_view.dart';
import 'package:mizan_app/features/expenses/views/expenses_view.dart';
import 'package:mizan_app/features/expenses/views/salary_view.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  double salary = 0;

  @override
  void initState() {
    super.initState();
    _loadSalary();
  }

  void _loadSalary() {
    final userBox = Hive.box(HiveConstants.userBox);
    final userMap = userBox.get(HiveConstants.user);
    if (userMap is Map) {
      setState(() {
        salary = (userMap['salary'] ?? 0).toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            WelcomeView(
              greetingMessage: LocaleKeys.expenses_room_description.tr(),
            ),

            SalaryView(salary: salary),

            ExpensesView(salary: salary),
          ],
        ),
      ),
    );
  }
}
