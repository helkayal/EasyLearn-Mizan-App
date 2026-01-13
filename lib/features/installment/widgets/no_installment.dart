import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class NoInstallment extends StatelessWidget {
  const NoInstallment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset(
          'assets/images/no_installment.png',
          width: MediaQuery.of(context).size.width * 0.75,
        ),
        SizedBox(height: 20),
        Text(
          LocaleKeys.installment_no_installments1.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          LocaleKeys.installment_no_installments2.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
