import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';

class OnboardingWidget1 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingWidget1({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 2 / 4.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: double.infinity,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'Roboto',
              color: campuscolor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'CrimsonText',
              color: Color(0xFF222222),
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}