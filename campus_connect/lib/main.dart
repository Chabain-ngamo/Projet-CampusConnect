import 'package:campus_connect/firebase_options.dart';
import 'package:campus_connect/l10n/l10n.dart';
import 'package:campus_connect/main_navigationbar.dart';
import 'package:campus_connect/models/userModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/providers/language_provider.dart';
import 'package:campus_connect/providers/like_provider.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/providers/user_provider.dart';
import 'package:campus_connect/views/screens/onboarding_page.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:campus_connect/views/screens/splash_screen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  PublicationProvider publicationProvider = PublicationProvider();
  LikeProvider likeProvider = LikeProvider();
  UsersProvider usersProvider = UsersProvider();
  DarkThemeProvider themeState = DarkThemeProvider();
  LanguageProvider languageProvider = LanguageProvider();
  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PublicationProvider>.value(
            value: publicationProvider),
        ChangeNotifierProvider<LikeProvider>.value(
            value: likeProvider),
        ChangeNotifierProvider<UsersProvider>.value(
            value: usersProvider),
        ChangeNotifierProvider<DarkThemeProvider>.value(
            value: themeState),
        ChangeNotifierProvider<LanguageProvider>.value(
            value: languageProvider),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'Campus Connect',
            locale: languageProvider.locale,
            supportedLocales: L10n.all,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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
            onGenerateRoute: (settings) {
              if (settings.name == '/publicationPage') {
                return MaterialPageRoute(
                  builder: (context) => PublicationPage(),
                  settings: settings,
                );
              }
              return null; // Important: retourner null pour les autres routes non gérées
            },
          );
        },
      ),
    );
  }
}
