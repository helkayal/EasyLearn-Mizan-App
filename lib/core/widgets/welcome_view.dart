import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key, required this.greetingMessage});

  final String greetingMessage;

  @override
  Widget build(BuildContext context) {
    final lang = context.locale.languageCode;

    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.lightGreenColor,
          child: Image.asset("assets/images/splash.png"),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGreenColor,
              borderRadius: lang == 'en'
                  ? const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
            ),
            child: Text(
              greetingMessage,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ],
    );
  }
}
