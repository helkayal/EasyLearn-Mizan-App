import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/features/home/screens/home_screen.dart';
import 'package:mizan_app/features/user/widgets/user_form.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr()), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/register.png',
                width: MediaQuery.of(context).size.width * 0.7,
                height: 160,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 16),

              UserForm(
                onSaved: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
