import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/core/data/countries.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class CurrencyDropdown extends StatelessWidget {
  final String? selectedCode;
  final ValueChanged<String?> onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return DropdownButtonFormField<String>(
      initialValue: selectedCode,
      hint: Text(LocaleKeys.currency_select_currency.tr()),
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      style: Theme.of(context).textTheme.bodyMedium,
      items: countries.map((c) {
        final name = lang == 'ar'
            ? (c['country_ar'] ?? '')
            : (c['country_en'] ?? '');
        final code = lang == 'ar'
            ? (c['currency_ar'] ?? '')
            : (c['currency_en'] ?? '');
        final flag = c['flag'] ?? '';
        return DropdownMenuItem(
          value: code,
          child: Text('$flag $code ($name)'),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
