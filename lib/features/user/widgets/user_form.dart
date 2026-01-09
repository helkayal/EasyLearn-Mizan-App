import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:mizan_app/core/widgets/mizan_button.dart';
import 'package:mizan_app/core/widgets/mizan_text_field.dart';
import 'package:mizan_app/features/user/widgets/mizan_picker_field.dart';
import 'package:mizan_app/features/user/helper/user_helper.dart';
import 'package:mizan_app/features/user/model/user_dm.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class UserForm extends StatefulWidget {
  final UserDm? initialUser;
  final VoidCallback? onSaved;

  const UserForm({super.key, this.initialUser, this.onSaved});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _userHelper = UserHelper();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _salaryController = TextEditingController();
  final _balanceController = TextEditingController();

  String? selectedCountry;

  @override
  void initState() {
    super.initState();

    if (widget.initialUser != null) {
      final user = widget.initialUser!;
      _nameController.text = user.name;
      _emailController.text = user.email;
      _salaryController.text = user.salary.toStringAsFixed(0);
      _balanceController.text = user.balance.toStringAsFixed(0);
      selectedCountry = user.country;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _salaryController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    await _userHelper.saveUser(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      salary: double.parse(_salaryController.text.replaceAll(',', '')),
      balance: double.parse(_balanceController.text.replaceAll(',', '')),
      country: selectedCountry ?? '',
    );

    if (!mounted) return;

    widget.onSaved?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        spacing: 20,
        children: [
          MizanTextField(
            label: LocaleKeys.personal_data_name.tr(),
            controller: _nameController,
            validator: _userHelper.requiredValidator,
          ),

          MizanTextField(
            label: LocaleKeys.personal_data_email.tr(),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: _userHelper.emailValidator,
          ),

          MizanTextField(
            label: LocaleKeys.personal_data_monthly_salary.tr(),
            controller: _salaryController,
            keyboardType: TextInputType.number,
            obscureText: true,
            validator: _userHelper.numericValidator,
          ),

          MizanTextField(
            label: LocaleKeys.personal_data_bank_balance.tr(),
            controller: _balanceController,
            keyboardType: TextInputType.number,
            obscureText: true,
            validator: _userHelper.numericValidator,
          ),

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
          const SizedBox(height: 10),

          MizanButton(
            text: widget.initialUser == null
                ? LocaleKeys.personal_data_button_text.tr()
                : LocaleKeys.personal_data_save.tr(),
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
