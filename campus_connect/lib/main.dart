import 'package:campus_connect/firebase_options.dart';
import 'package:campus_connect/main_navigationbar.dart';
import 'package:campus_connect/views/screens/onboarding_page.dart';
import 'package:campus_connect/views/screens/splash_screen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
        '/': (context) => SplashScreen(
                child: FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? userId = snapshot.data!.getString('userId');
                      if (userId != null && userId.isNotEmpty) {
                        return MainNavigationBar();
                      } else {
                        return OnboardingPage();
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),

      },
    );
  }
}


