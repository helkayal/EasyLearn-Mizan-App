import 'package:easy_localization/easy_localization.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mizan_app/core/utils/hive_constants.dart';
import 'package:mizan_app/features/user/model/user_dm.dart';
import 'package:mizan_app/generated/locale_keys.g.dart';

class UserHelper {
  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.personal_data_required_field.tr();
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.personal_data_required_field.tr();
    }
    final email = value.trim();
    final emailRegex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(email)) {
      return LocaleKeys.personal_data_invalid_email.tr();
    }
    return null;
  }

  String? numericValidator(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.personal_data_required_field.tr();
    }
    final text = value.replaceAll(',', '').trim();
    if (num.tryParse(text) == null) {
      return LocaleKeys.personal_data_must_be_number.tr();
    }
    return null;
  }

  UserDm? loadUser() {
    final box = Hive.box(HiveConstants.userBox);
    final data = box.get(HiveConstants.user);

    if (data == null) return null;

    return UserDm.fromMap(Map<String, dynamic>.from(data));
  }

  Future<void> saveUser({
    required String name,
    required String email,
    required double salary,
    required double balance,
    required String country,
  }) async {
    final user = UserDm(
      name: name,
      email: email,
      salary: salary,
      balance: balance,
      country: country,
    );

    final box = Hive.box(HiveConstants.userBox);
    await box.put(HiveConstants.user, user.toMap());
    await box.put(HiveConstants.isLoggedin, true);
  }

  Future<void> logout() async {
    final box = Hive.box(HiveConstants.userBox);
    await box.clear();
  }
}
