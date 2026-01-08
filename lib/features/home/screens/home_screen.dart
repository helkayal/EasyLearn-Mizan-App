import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(HiveConstants.userBox);

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr())),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box b, _) {
          final userMap = b.get('user');
          final name = (userMap is Map) ? (userMap['name'] ?? '') : '';
          final welcome = name != null && name.toString().isNotEmpty
              ? 'Welcome $name to the Home Screen!'
              : 'Welcome to the Home Screen!';

          return Center(child: Text(welcome));
        },
      ),
    );
  }
}
