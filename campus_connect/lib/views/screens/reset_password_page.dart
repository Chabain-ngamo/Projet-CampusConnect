import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();

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
              flex: 1,
              child: _buildTop()),
            _buildBackButton(context),
            Expanded(
              flex: 5,
              child: _buildBottom()),
            _buildLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Image.asset(
        'logo.png',
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

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Forgot Password",
          style: TextStyle(
              color: darkColor , fontSize: 32, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 30),
        const Text(
          "Please, enter your email address, you will receive a link to create a new password via email",
          style: TextStyle(
              color: darkColor , fontSize: 14,  fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 20),
        _buildGreyText("Email"),
        _buildInputField(emailController),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: greyColor, fontFamily: 'Roboto'),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Entrez votre email',
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
        onPressed: () {
          debugPrint("Email : ${emailController.text}");
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0),),
          elevation: 20,
          shadowColor: campuscolor,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("SEND"),
      ),
    );
  }
}
