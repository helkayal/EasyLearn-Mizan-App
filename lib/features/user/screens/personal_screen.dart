import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/features/splash/splash_screen.dart';
import 'package:mizan_app/features/user/model/user_dm.dart';
import 'package:mizan_app/features/user/widgets/edit_profile_dialog.dart';
import 'package:mizan_app/features/user/widgets/personal_card.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';
import 'package:mizan_app/features/user/helper/user_helper.dart';

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  UserDm? user;
  final _userHelper = UserHelper();

  @override
  void initState() {
    super.initState();
    user = _userHelper.loadUser();

    user ??= UserDm(name: "", email: "", salary: 0, balance: 0, country: "");
  }

  // void _editProfile() async {
  //   final updated = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (_) => EditPersonalScreen(user: user!)),
  //   );

  //   if (updated == true) {
  //     setState(() {
  //       user = _userHelper.loadUser();
  //     });
  //   }
  // }

  void _editProfile() async {
    final updated = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => EditProfileDialog(user: user!),
    );

    if (updated == true) {
      setState(() {
        user = _userHelper.loadUser();
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.personal_data_updated_successfully.tr()),
        ),
      );
    }
  }

  void _logout() async {
    await _userHelper.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const SplashScreen()),
      (_) => false,
    );
  }

  void _toggleLanguage() async {
    final isArabic = context.locale.languageCode == 'ar';

    await context.setLocale(isArabic ? const Locale('en') : const Locale('ar'));
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.app_name.tr()),
        actions: [
          IconButton(icon: Icon(Icons.language), onPressed: _toggleLanguage),
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PersonalCard(user: user, onEdit: _editProfile),
            ),
          ],
        ),
      ),
    );
  }
}
