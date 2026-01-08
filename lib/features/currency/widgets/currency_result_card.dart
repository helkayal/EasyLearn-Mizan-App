import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/core/theme/app_colors.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class CurrencyResultCard extends StatelessWidget {
  final String country;
  final String code;
  final String amount;
  final String result;
  final String target;

  const CurrencyResultCard({
    super.key,
    required this.country,
    required this.code,
    required this.amount,
    required this.result,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.lightGreenColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        LocaleKeys.currency_result_format.tr(
          namedArgs: {
            'country': country,
            'code': code,
            'amount': amount,
            'result': result,
            'target': target,
          },
        ),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
