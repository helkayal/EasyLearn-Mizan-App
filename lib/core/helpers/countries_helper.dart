import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mizan_app/core/data/countries.dart';

class CountriesHelper {
  String? displayNameForId(BuildContext context, String? id) {
    if (id == null || id.isEmpty) return null;
    final lang = context.locale.languageCode;
    try {
      final entry = countries.firstWhere(
        (c) => (c['country_id'] ?? '') == id,
        orElse: () => {},
      );
      if (entry.isEmpty) return id;
      return lang == 'ar' ? entry['country_ar'] : entry['country_en'];
    } catch (_) {
      return id;
    }
  }

  String? flagForId(BuildContext context, String? id) {
    if (id == null || id.isEmpty) return null;
    try {
      final entry = countries.firstWhere(
        (c) => (c['country_id'] ?? '') == id,
        orElse: () => {},
      );
      if (entry.isEmpty) return null;
      return entry['flag'];
    } catch (_) {
      return null;
    }
  }
}
