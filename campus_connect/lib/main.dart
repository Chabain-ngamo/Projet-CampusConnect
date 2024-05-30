import 'package:campus_connect/views/screens/onboarding_page.dart';
import 'package:campus_connect/views/screens/splash_screen_page.dart';
import 'package:flutter/material.dart';

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
    );
  }
}

