import 'package:campus_connect/controllers/notification_controller.dart';
import 'package:campus_connect/provider/provider.dart';
import 'package:campus_connect/views/screens/chat_page.dart';
import 'package:campus_connect/views/screens/notification_page.dart';
import 'package:campus_connect/views/screens/onboarding_page.dart';
import 'package:campus_connect/views/screens/profil_page.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:campus_connect/views/screens/search_page.dart';
import 'package:campus_connect/views/screens/splash_screen_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'firebase_options.dart';

void main() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/logo',
    [
      NotificationChannel(
        channelGroupKey: "campus_connect_group",
        channelKey: "campus_connect", 
        channelName: "Campus Connect", 
        channelDescription: "Test des notifications",
        )
    ],
    channelGroups:  [
      NotificationChannelGroup(
        channelGroupKey: "campus_connect_group", 
        channelGroupName: "Basic Campus Connect Group")
    ],
  );
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            title: 'Campus Connect',
            routes: {
              '/': (context) => const SplashScreen(
                child: OnboardingPage(),
              ),

            },
            locale: const Locale("en"),
            
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            themeMode: notifier.isDark? ThemeMode.dark : ThemeMode.light,

            //Our custom theme applied
            darkTheme: notifier.isDark? notifier.darkTheme : notifier.lightTheme,
          );
        }
      ),
    );
  }
}


