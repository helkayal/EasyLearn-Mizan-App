import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/core/helpers/countries_helper.dart';
import 'package:mizan_app/features/user/model/user_dm.dart';
import 'package:mizan_app/features/user/widgets/info_circle.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class PersonalCard extends StatelessWidget {
  final UserDm? user;
  final VoidCallback onEdit;

  const PersonalCard({super.key, required this.user, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          padding: const EdgeInsets.only(top: 70),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            children: [
              /// Name
              Text(user!.name, style: theme.textTheme.titleLarge),

              const SizedBox(height: 4),

              /// Email
              Text(user!.email, style: theme.textTheme.bodyMedium),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  CountriesHelper().displayNameForId(context, user!.country) ??
                      '',
                  style: theme.textTheme.headlineMedium,
                ),
              ),

              const SizedBox(height: 32),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InfoCircle(
                      value: user!.salary.toString(),
                      labelKey: LocaleKeys.personal_data_monthly_salary,
                    ),
                    InfoCircle(
                      value: user!.balance.toString(),
                      labelKey: LocaleKeys.personal_data_bank_balance,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Edit Button
              SizedBox(
                width: size.width * 0.5,
                child: ElevatedButton(
                  onPressed: onEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                  ),
                  child: Text(LocaleKeys.personal_data_edit.tr()),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),

        CircleAvatar(
          radius: 70,
          backgroundColor: theme.colorScheme.onPrimary,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: theme.colorScheme.onPrimary,
            backgroundImage: const AssetImage('assets/images/personal.png'),
          ),
        ),
      ],
    );
  }
}
