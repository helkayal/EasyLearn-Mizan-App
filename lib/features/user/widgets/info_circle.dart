import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class InfoCircle extends StatelessWidget {
  final String value;
  final String labelKey;

  const InfoCircle({super.key, required this.value, required this.labelKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * 0.3,
          height: size.width * 0.3,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.colorScheme.secondary, width: 4),
          ),
          child: Text(value, style: theme.textTheme.headlineSmall),
        ),
        const SizedBox(height: 12),
        Text(labelKey.tr(), style: theme.textTheme.headlineSmall),
      ],
    );
  }
}
