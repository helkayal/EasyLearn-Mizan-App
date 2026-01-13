import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/features/currency/screens/currency_screen.dart';
import 'package:mizan_app/core/widgets/welcome_view.dart';
import 'package:mizan_app/features/expenses/screens/expenses_screen.dart';
import 'package:mizan_app/features/home/widgets/home_action_card.dart';
import 'package:mizan_app/features/installment/screens/installment_screen.dart';
import 'package:mizan_app/features/user/screens/personal_screen.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box(HiveConstants.userBox);
    final userMap = userBox.get(HiveConstants.user);
    final name = (userMap is Map) ? (userMap['name'] ?? '') : '';
    final greetingMessage = LocaleKeys.home_welcome_message.tr(
      namedArgs: {'name': name},
    );

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            /// Welcome Card
            WelcomeView(greetingMessage: greetingMessage),

            const SizedBox(height: 20),

            HomeActionCard(
              title: LocaleKeys.home_currency_to_usd.tr(),
              icon: Image.asset("assets/images/icCurrency.png"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CurrencyScreen()),
                );
              },
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_installments_title.tr(),
              icon: Image.asset("assets/images/icInstallement.png"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InstallmentScreen()),
                );
              },
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_expenses_organizer.tr(),
              icon: Image.asset("assets/images/icExpenses.png"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExpensesScreen()),
                );
              },
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_personal_data.tr(),
              icon: Image.asset("assets/images/icPersonal.png"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PersonalScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
