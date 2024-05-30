import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/home_screen_page.dart';
import 'package:campus_connect/views/widgets/onboardingW1.dart';
import 'package:campus_connect/views/widgets/onboardingW2.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 12,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: const [
                    OnboardingWidget1(
                      imagePath: 'assets/Team_spirit.png',
                      title: "Exchange",
                      description:
                          "Easily exchange messages with your classmates to help each other while you learn.",
                    ),
                    OnboardingWidget1(
                      imagePath: 'assets/Graduation.png',
                      title: "Collaborate",
                      description:
                          "Collaborate with your friends and classmates by sending messages, files and comments within the app.",
                    ),
                    OnboardingWidget2(
                      imagePath: 'assets/theme4.png',
                      imagePath2: 'assets/theme3.png',
                      imagePath3: 'assets/onboarding1.png',
                      imagePath4: 'assets/theme2.png',
                      title: "Read the publication you want instantly",
                      description:
                          "you can create and share publications on campus connect, comment on them and communicate easily between students",
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(
                      3,
                      (int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: _buildIndicator(index),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          if (_currentPage == 2)
            Positioned(
              right: 20,
              bottom: 30,
              child: SizedBox(
                height: 50,
                width: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => HomeScreenPage()))
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: campuscolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    return _currentPage == index
        ? Container(
            width: 30.0,
            height: 10.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: campuscolor,
            ),
          )
        : Container(
            width: 10.0,
            height: 10.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
            ),
          );
  }
}

