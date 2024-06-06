import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isEnglishSelected = true;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Container(
      decoration: const BoxDecoration(color: backColor),
      child: Scaffold(
        backgroundColor: colorB,
        body: Stack(
          children: [
            ButtonBackWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: mediaSize.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              AppLocalizations.of(context)!.settings,
                              style: TextStyle(
                                color: color,
                                  //color: darkColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto'),
                            ),
                            const SizedBox(height: 20),
                            Card(
                              color: colorB,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: campuscolor, 
                                  width: 2.0,        
                                ),
                              ),
                              
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Theme",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: color,
                                              fontFamily: 'Roboto'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: SwitchListTile(
                                        title: Text(
                                          themeState.getDarkTheme
                                              ? 'Dark mode'
                                              : 'Light mode',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: color,
                                          ),
                                        ),
                                        secondary: Icon(
                                          themeState.getDarkTheme
                                              ? Icons.dark_mode_outlined
                                              : Icons.light_mode_outlined,
                                          color: color,
                                        ),
                                        onChanged: (bool value) {
                                          setState(() {
                                            themeState.setDarkTheme = value;
                                          });
                                        },
                                        value: themeState.getDarkTheme,
                                        activeColor: campuscolor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEnglishSelected = !isEnglishSelected;
                                });
                              },
                              child: Card(
                                color: colorB,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                  side: BorderSide(
                                  color: campuscolor, 
                                  width: 2.0,        
                                ),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                        "Language",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: color,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Roboto'),
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            "English",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: color,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Checkbox(
                                            value: isEnglishSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isEnglishSelected =
                                                    value ?? false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            "Français",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: color,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Checkbox(
                                            value: !isEnglishSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                isEnglishSelected =
                                                    !(value ?? false);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
