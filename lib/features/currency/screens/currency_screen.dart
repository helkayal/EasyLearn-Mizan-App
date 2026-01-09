import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/core/data/countries.dart';
import 'package:mizan_app/core/data/curreny_conversion.dart';
import 'package:mizan_app/core/widgets/mizan_button.dart';
import 'package:mizan_app/core/widgets/mizan_text_field.dart';
import 'package:mizan_app/core/widgets/welcome_view.dart';
import 'package:mizan_app/features/user/helper/user_controller.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';
import '../widgets/currency_result_card.dart';
import '../widgets/currency_dropdown.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController _amountController = TextEditingController();

  String selectedCountry = '';
  String? selectedCode;
  String? currencyCode; // Store English currency code for exchange rates
  String result = '0.00';
  bool showResultCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            WelcomeView(greetingMessage: LocaleKeys.currency_description.tr()),

            const SizedBox(height: 30),

            CurrencyDropdown(
              selectedCode: selectedCode,
              onChanged: (value) {
                final lang = context.locale.languageCode;
                setState(() {
                  selectedCode = value;
                  final found = countries.firstWhere(
                    (c) =>
                        (c['currency_en'] ?? '') == value ||
                        (c['currency_ar'] ?? '') == value,
                    orElse: () => <String, String>{},
                  );
                  currencyCode = found.isNotEmpty
                      ? (found['currency_en'] ?? '')
                      : null;
                  selectedCountry = found.isNotEmpty
                      ? (lang == 'ar'
                            ? (found['country_ar'] ?? '')
                            : (found['country_en'] ?? ''))
                      : '';
                  result = '0.00';
                  _amountController.clear();
                  showResultCard = false;
                });
              },
            ),

            const SizedBox(height: 15),

            MizanTextField(
              label: LocaleKeys.currency_enter_amount.tr(),
              controller: _amountController,
              keyboardType: TextInputType.number,
              validator: UserHelper().numericValidator,
            ),

            const SizedBox(height: 15),

            MizanButton(
              text: LocaleKeys.currency_convert.tr(),
              onPressed: () {
                if (_amountController.text.isEmpty || currencyCode == null) {
                  return;
                }
                setState(() {
                  final amount = double.tryParse(_amountController.text) ?? 0.0;
                  final rate = exchangeRatesToUSD[currencyCode] ?? 1.0;
                  final convertedAmount = amount / rate;
                  result = convertedAmount.toStringAsFixed(2);
                  showResultCard = true;
                });
              },
            ),

            const SizedBox(height: 30),

            /// Result Card
            showResultCard
                ? CurrencyResultCard(
                    country: selectedCountry,
                    code: selectedCode ?? '',
                    amount: _amountController.text.isEmpty
                        ? '0'
                        : _amountController.text,
                    result: result,
                    target: LocaleKeys.currency_usd.tr(),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
