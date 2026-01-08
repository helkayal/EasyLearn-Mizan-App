import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_colors.dart';
import 'package:mizan_app/core/theme/app_text_styles.dart';

class HomeActionCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onTap;

  const HomeActionCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.greenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(title, style: AppTextStyles.lightYellow20SemiBold),
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.lightYellowColor,
              child: icon,
            ),
          ],
        ),
      ),
    );
  }
}
