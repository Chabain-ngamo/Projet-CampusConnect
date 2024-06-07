import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    final List<Map<String, String>> notificationList = [
      {
        'notif': 'the x4 tutor will be absent today',
        'moment': 'Just Now',
      },
      {
        'notif': 'the x4 tutor will be absent today',
        'moment': 'Just Now',
      },
      {
        'notif': 'the x4 tutor will be absent today',
        'moment': 'Just Now',
      },
      {
        'notif': 'the x4 tutor will be absent today',
        'moment': 'Just Now',
      },
      {
        'notif': 'the x4 tutor will be absent today',
        'moment': 'Just Now',
      },
    ];

    return Scaffold(
      backgroundColor: colorB,
        body: Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children:  [
                  Text(
                     AppLocalizations.of(context)!.notification,
                    style: TextStyle(
                      color: color,
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration:  BoxDecoration(
                  color: colorB,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: fondcolor,
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(notificationList.length, (index) {
                    return Column(
                      children: [
                        NotificationCard(
                          NotificationData: notificationList[index],
                        ),
                        if (index < notificationList.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                                color: Color.fromARGB(116, 158, 158, 158),
                                thickness: 1),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
      ButtonBackWidget()
    ]));
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, String> NotificationData;

  NotificationCard({
    required this.NotificationData,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return ListTile(
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: Container(
          decoration: const BoxDecoration(
            color: campuscolor,
          ),
          width: 45,
          height: 45,
          child: Image.asset('assets/gps.png'),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              NotificationData['notif']!,
              style:  TextStyle(
                color: color,
                fontSize: 18,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Row(
          children: [
            Icon(
              Icons.access_time_filled_sharp,
              size: 18,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              NotificationData['moment']!,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'CrimsonText',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
