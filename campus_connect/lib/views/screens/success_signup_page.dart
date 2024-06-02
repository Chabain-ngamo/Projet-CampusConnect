import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';

class SuccessSignUpPage extends StatefulWidget {
  const SuccessSignUpPage({super.key});

  @override
  State<SuccessSignUpPage> createState() => _SuccessSignUpPageState();
}

class _SuccessSignUpPageState extends State<SuccessSignUpPage> {
  late Size mediaSize;
    @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: backColor
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: _buildBottom()),
            _buildUpdateButton()
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
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 2 / 4.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/Confirmed_bro.png',
          width: double.infinity,
          height: imageHeight,
          fit: BoxFit.contain,
        ),
        const Center(
          child: Text(
            "Congrats!",
            style: TextStyle(
              fontSize: 32,
              fontFamily: 'Roboto',
              color: campuscolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        const Center(
          child: Text(
            "Your Profile Is Ready To Be Used",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'CrimsonText',
              color: darkColor,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
          elevation: 20,
          shadowColor: campuscolor,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("LOGIN"),
      ),
    );
  }
}
/* voici ça*/ 