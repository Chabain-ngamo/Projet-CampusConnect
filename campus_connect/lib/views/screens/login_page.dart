import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/reset_password_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(25, 55, 107, 237),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Positioned(top: 60, child: _buildTop()),
          Positioned(bottom: 80, child: _buildButton()),
          Positioned(bottom: 0, child: _buildBottom()),
        ]),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Image.asset(
        'logo.png',
        width: 150,
        height: 150,
      ),
    );
  }



  Widget _buildButton() {
    return SizedBox(
      width: mediaSize.width,
      child: const Card(
        color: campuscolor,
        
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }




  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome back",
          style: TextStyle(
              color: darkColor , fontSize: 32, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        _buildGreyText("Sign in with your account"),
        const SizedBox(height: 60),
        _buildGreyText("Username"),
        _buildInputField(emailController),
        const SizedBox(height: 40),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildLoginButton(),
        const SizedBox(height: 20),
        _buildRememberForgot(),
        const SizedBox(height: 20),
        _buildOtherLogin(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: greyColor),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            _buildGreyText("Forgot your password?"),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => const ResetPasswordPage()))
                    );
                }, 
                child: const Text("Reset here", style: TextStyle(color: campuscolor))
            ),
          ],
        )
      ]
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
        elevation: 20,
        shadowColor: campuscolor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("LOGIN"),
    );
  }

  Widget _buildOtherLogin() {
    return Center(
      child: Column(
        children: [
          _buildGreyText("OR SIGN IN WITH"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("google.png")),
              Tab(icon: Image.asset("facebook.png")),
              Tab(icon: Image.asset("twitter.png")),
            ],
          )
        ],
      ),
    );
  }
}
 