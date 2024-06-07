import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('en'),
    const Locale('fr'),
  ];

  static String getLanguage(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      default:
        return 'English';
    }
  }
}
