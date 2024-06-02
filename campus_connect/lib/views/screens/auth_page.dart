import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/home_screen_page.dart';
import 'package:campus_connect/views/screens/reset_pass_page.dart';
import 'package:campus_connect/views/screens/success_signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();
  bool isSignUp = false;

  void _toggleWidget(bool signUp) {
    setState(() {
      isSignUp = signUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildTop(),
              _buildButton(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: Image.asset(
        'assets/logo.png',
        width: 130,
        height: 130,
      ),
    );
  }

  Widget _buildButton() {
    return Container(
        width: mediaSize.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          boxShadow: [
            BoxShadow(
              color: campuscolor,
              spreadRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        _toggleWidget(false);
                      });
                    },
                    child: Text("LOGIN",
                        style: TextStyle(
                            color: isSignUp ? Color.fromARGB(124, 255, 255, 255) : Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'))),
                TextButton(
                    onPressed: () {
                      setState(() {
                        _toggleWidget(true);
                      });
                    },
                    child: Text("SIGN UP",
                        style: TextStyle(
                            color: isSignUp ? Colors.white : Color.fromARGB(124, 255, 255, 255),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto'))),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            isSignUp ? _buildBottom() : _buildBottom1(),
          ],
        ));
  }

  //-------------------------------------------------------------------------------------
  //widget pour le login

  Widget _buildBottom1() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: _buildForm1(),
      ),
    );
  }

  Widget _buildForm1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome back",
          style: TextStyle(
              color: darkColor,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 10),
        _buildGreyText1("Sign in with your account"),
        const SizedBox(height: 30),
        _buildGreyText1("Username"),
        _buildInputField1(emailController),
        const SizedBox(height: 30),
        _buildGreyText1("Password"),
        _buildInputField1(passwordController, isPassword: true),
        const SizedBox(height: 40),
        _buildLoginButton1(),
        const SizedBox(height: 10),
        _buildRememberForgot1(),
        const SizedBox(height: 20),
        _buildOtherLogin1(),
      ],
    );
  }

  Widget _buildGreyText1(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: greyColor,
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w700),
    );
  }

  Widget _buildInputField1(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot1() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(
        children: [
          _buildGreyText1("Forgot your password?"),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const ResetPasswordPage())));
              },
              child: const Text("Reset here",
                  style: TextStyle(
                      color: campuscolor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto'))),
        ],
      )
    ]);
  }

  Widget _buildLoginButton1() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
        Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const HomeScreenPage())));
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
      child: const Text("LOGIN",
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildOtherLogin1() {
    return Center(
      child: Column(
        children: [
          _buildGreyText1("OR SIGN IN WITH"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Tab(icon: Image.asset("assets/google.png")),
              Tab(icon: Image.asset("assets/facebook.png")),
              Tab(icon: Image.asset("assets/twitter.png")),
            ],
          )
        ],
      ),
    );
  }
//---------------------------------------------------------------------------------------------------
//widget pour le SignUp

  Widget _buildBottom() {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      width: mediaSize.width,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Sign Up For Free",
          style: TextStyle(
            color: darkColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
        const SizedBox(height: 40),
        _buildGreyText("Username"),
        _buildInputField(userController),
        const SizedBox(height: 20),
        _buildGreyText("Email"),
        _buildInputField(emailController),
        const SizedBox(height: 20),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 100),
        _buildLoginButton(),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: greyColor,
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w700),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? const Icon(Icons.remove_red_eye)
            : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("User : ${userController.text}");
        debugPrint("Email : ${emailController.text}");
        debugPrint("Password : ${passwordController.text}");
        Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => SuccessSignUp()))
                    );
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
      child: const Text(
        "SIGN UP",
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 16,
            fontWeight: FontWeight.w700),
      ),
    );
  }

//--------------------------------------------------------------------------------------------------

}
