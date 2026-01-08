import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_colors.dart';

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
      child: Column(
        spacing: 5,
        children: [
          Text(
            "$amount $code ",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Icon(
            Icons.assignment_returned_outlined,
            size: 32,
            color: AppColors.greyColor,
          ),
          Text(
            "$result $target",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
