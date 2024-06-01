import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
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
    return Container(
      decoration: const BoxDecoration(
        color: backColor
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ButtonBackWidget(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 50,),
                _buildBottom(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _buildForm(),
          ),
        ],
      ),
    );
  }


  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Settings",
          style: TextStyle(
              color: darkColor, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 20),
        _buildDarkModeCard(),
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
              const Text(
                "Language",
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
                  const Text(
                    "English",
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
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Français",
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


  Widget _buildDarkModeCard() {
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
              children: const [
                 Text(
                  "Theme",
                  style: TextStyle(
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
                  'assets/iconssun.png',
                  width: 50,
                  height: 50,
                  color: campuscolor,
                ),
                const Text(
                  "Light mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: true,
                  onChanged: (value) {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}