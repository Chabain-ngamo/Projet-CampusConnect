import 'package:campus_connect/views/screens/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:campus_connect/services/constant.dart'; // chabain stp rasure toi de bien faire les redirection merci

class SuccessSignUp extends StatefulWidget {
  const SuccessSignUp({super.key});

  @override
  State<SuccessSignUp> createState() => _SuccessSignupPageState();
}

class _SuccessSignupPageState extends State<SuccessSignUp> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 2 / 4.5;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/Confirmed_bro.png',
            width: double.infinity,
            height: imageHeight,
            fit: BoxFit.contain,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Congrats!",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                color: campuscolor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Your Profile Is Ready To Use",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'CrimsonText',
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 80),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => AuthPage())));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: campuscolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 20,
                    shadowColor: campuscolor,
                    minimumSize: const Size.fromHeight(60),
                  ),
                  child: const Text("LOGIN",style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w700),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
