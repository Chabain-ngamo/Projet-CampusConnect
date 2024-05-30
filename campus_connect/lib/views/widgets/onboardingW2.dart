import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';

class OnboardingWidget2 extends StatelessWidget {
  final String imagePath;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4;
  final String title;
  final String description;

  const OnboardingWidget2({
    required this.imagePath,
    required this.imagePath2,
    required this.imagePath3,
    required this.imagePath4,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenHeight * 2 / 4.5;
    final double containHeight = imageHeight / 2;

    return Container(
      color: Color.fromARGB(25, 55, 107, 237),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: Image.asset(
                                  imagePath2,
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: Image.asset(
                                  imagePath3,
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(30.0)),
                                child: Image.asset(
                                  imagePath4,
                                  fit: BoxFit.cover,
                                  height: 180,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 25, right: 25, bottom: 30),
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
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 30),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontFamily: 'CrimsonText',
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}