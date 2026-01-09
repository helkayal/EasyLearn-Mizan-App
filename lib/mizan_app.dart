import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/core/theme/app_theme.dart';
import 'package:mizan_app/features/splash/splash_screen.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class MizanApp extends StatelessWidget {
  const MizanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: ValueKey('${context.locale.languageCode}_app'),
      debugShowCheckedModeBanner: false,
      title: LocaleKeys.app_name.tr(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
