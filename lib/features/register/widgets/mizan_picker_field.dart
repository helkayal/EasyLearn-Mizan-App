import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mizan_app/core/data/countries.dart';

void _showCountryPicker(
  BuildContext context,
  void Function(String) onSelected,
) {
  final lang = context.locale.languageCode;
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return SizedBox(
        height: 400,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: countries.length,
          itemBuilder: (ctx, i) {
            final country = countries[i];
            final name = lang == 'ar'
                ? country['country_ar'] ?? ''
                : country['country_en'] ?? '';
            final flag = country['flag'] ?? '';
            return ListTile(
              leading: Text(flag, style: const TextStyle(fontSize: 24)),
              title: Text(name),
              onTap: () {
                Navigator.pop(context);
                onSelected(name);
              },
            );
          },
        ),
      );
    },
  );
}

class MizanPickerFormField extends FormField<String> {
  MizanPickerFormField({
    super.key,
    required String label,
    String? value,
    super.validator,
    void Function(String)? onChanged,
  }) : super(
         initialValue: value,
         builder: (field) {
           final theme = Theme.of(field.context);

           final decoration = const InputDecoration()
               .applyDefaults(theme.inputDecorationTheme)
               .copyWith(
                 labelText: label,
                 errorText: field.errorText,
                 suffixIcon: const Icon(Icons.keyboard_arrow_down),
               );

           return InkWell(
             onTap: () {
               _showCountryPicker(field.context, (selected) {
                 field.didChange(selected);
                 if (onChanged != null) onChanged(selected);
               });
             },
             child: InputDecorator(
               decoration: decoration,
               isEmpty: field.value == null || field.value!.isEmpty,
               child: Text(
                 field.value ?? '',
                 style: theme.textTheme.bodyMedium,
               ),
             ),
           );
         },
       );
}
