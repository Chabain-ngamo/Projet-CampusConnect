import 'package:campus_connect/provider/provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


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
    return ChangeNotifierProvider(
      create: (BuildContext context)=>UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return Container(
            decoration: BoxDecoration(
              color: notifier.isDark ? campuscolor : backColor,
            ),
            child: Scaffold(
              backgroundColor: notifier.isDark ? darkColor : Colors.white,
              body: Stack(
                children: [
                  ButtonBackWidget(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      _buildBottom(context, notifier),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  

  Widget _buildBottom(BuildContext context, UiProvider notifier) {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildForm(context, notifier),
          ),
        ],
      ),
    );
  }


  Widget _buildForm(BuildContext context, UiProvider notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(
              color: notifier.isDark ? greyColor :darkColor, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 20),
        _buildDarkModeCard(context, notifier),
        const SizedBox(height: 20),
        _buildLanguageCard(),
      ],
    );
  }

  Widget _buildLanguageCard() {
  
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnglishSelected = !isEnglishSelected;
        });},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto'
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.english,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(
                    value: isEnglishSelected,
                    onChanged: (value) {
                      setState(() {
                        isEnglishSelected = value ?? false;
                        Locale("en");
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.french,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Checkbox(
                    value: !isEnglishSelected,
                    onChanged: (value) {
                      setState(() {
                        isEnglishSelected = !(value ?? false);
                        Locale("fr");
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildDarkModeCard(BuildContext context, UiProvider notifier) {
    
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  AppLocalizations.of(context)!.theme,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  notifier.isDark ? 'assets/dark.png' : 'assets/iconssun.png',
                  width: 50,
                  height: 50,
                  color: notifier.isDark ? greyColor : campuscolor,
                ),
                Text(
                  notifier.isDark ? AppLocalizations.of(context)!.mode : AppLocalizations.of(context)!.mode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: notifier.isDark,
                  onChanged: (value)=>notifier.changeTheme()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}