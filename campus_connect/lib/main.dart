import 'package:campus_connect/l10n/l10n.dart';
import 'package:campus_connect/views/screens/chat_page.dart';
import 'package:campus_connect/views/screens/notification_page.dart';
import 'package:campus_connect/views/screens/onboarding_page.dart';
import 'package:campus_connect/views/screens/profil_page.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:campus_connect/views/screens/search_page.dart';
import 'package:campus_connect/views/screens/splash_screen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Connect',
      routes: {
        '/': (context) => const SplashScreen(
          child: OnboardingPage(),
        ),

      },
      locale: const Locale("fr"),
      
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}


