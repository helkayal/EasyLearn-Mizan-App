import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/features/home/screens/home_screen.dart';
import 'package:mizan_app/features/user/helper/user_controller.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';
import 'package:mizan_app/core/widgets/mizan_button.dart';
import 'package:mizan_app/features/user/widgets/mizan_picker_field.dart';
import 'package:mizan_app/core/widgets/mizan_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _salaryController = TextEditingController();
  final _balanceController = TextEditingController();

  final _controller = UserHelper();

  String? selectedCountry;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _salaryController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.app_name.tr()), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Image.asset(
                    'assets/images/register.png',
                    width: size.width * 0.7,
                    height: 160,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 16),

                  MizanTextField(
                    label: LocaleKeys.personal_data_name.tr(),
                    controller: _nameController,
                    validator: _controller.requiredValidator,
                  ),

                  const SizedBox(height: 12),

                  MizanTextField(
                    label: LocaleKeys.personal_data_email.tr(),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _controller.emailValidator,
                  ),

                  const SizedBox(height: 12),

                  MizanTextField(
                    label: LocaleKeys.personal_data_monthly_salary.tr(),
                    controller: _salaryController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: _controller.numericValidator,
                  ),

                  const SizedBox(height: 12),

                  MizanTextField(
                    label: LocaleKeys.personal_data_bank_balance.tr(),
                    controller: _balanceController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: _controller.numericValidator,
                  ),

                  const SizedBox(height: 12),

                  MizanPickerFormField(
                    label: LocaleKeys.personal_data_choose_country.tr(),
                    value: selectedCountry,
                    validator: (value) => value == null || value.isEmpty
                        ? LocaleKeys.personal_data_required_field.tr()
                        : null,
                    onChanged: (country) {
                      setState(() => selectedCountry = country);
                    },
                  ),

                  const SizedBox(height: 20),

                  MizanButton(
                    text: LocaleKeys.personal_data_button_text.tr(),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final salary = double.parse(
                        _salaryController.text.replaceAll(',', '').trim(),
                      );
                      final balance = double.parse(
                        _balanceController.text.replaceAll(',', '').trim(),
                      );
                      final country = selectedCountry ?? '';

                      final messenger = ScaffoldMessenger.of(context);
                      final navigator = Navigator.of(context);

                      await _controller.saveUser(
                        name: name,
                        email: email,
                        salary: salary,
                        balance: balance,
                        country: country,
                      );

                      if (!mounted) return;

                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(
                            LocaleKeys.personal_data_data_saved_successfully
                                .tr(),
                          ),
                        ),
                      );

                      // Navigate to Home
                      navigator.pushReplacement(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
