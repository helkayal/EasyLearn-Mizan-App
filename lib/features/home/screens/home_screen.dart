import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/features/home/views/welcome_view.dart';
import 'package:mizan_app/features/home/widgets/home_action_card.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            /// Welcome Card
            WelcomeView(),

            const SizedBox(height: 20),

            HomeActionCard(
              title: LocaleKeys.home_currency_to_usd.tr(),
              icon: Image.asset("assets/images/icCurrency.png"),
              onTap: () {},
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_installments_title.tr(),
              icon: Image.asset("assets/images/icInstallement.png"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Scaffold(
                      appBar: AppBar(
                        title: Text(LocaleKeys.home_installments_title.tr()),
                      ),
                      body: Center(
                        child: Text(LocaleKeys.home_installments_title.tr()),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_expenses_organizer.tr(),
              icon: Image.asset("assets/images/icExpenses.png"),
              onTap: () {},
            ),

            const SizedBox(height: 16),

            HomeActionCard(
              title: LocaleKeys.home_personal_data.tr(),
              icon: Image.asset("assets/images/icPersonal.png"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
