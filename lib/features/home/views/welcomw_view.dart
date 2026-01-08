import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mizan_app/core/theme/app_colors.dart';
import 'package:mizan_app/core/theme/app_text_styles.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final userBox = Hive.box(HiveConstants.userBox);
    final userMap = userBox.get(HiveConstants.user);
    final name = (userMap is Map) ? (userMap['name'] ?? '') : '';

    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: AppColors.lightGreenColor,
          child: Image.asset("assets/images/splash.png"),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightGreenColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Text(
              LocaleKeys.welcome_message.tr(namedArgs: {'name': name}),
              style: AppTextStyles.black16SemiBold,
            ),
          ),
        ),
      ],
    );
  }
}
