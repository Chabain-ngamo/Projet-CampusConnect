import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:campus_connect/services/loading_manager.dart';
import 'package:campus_connect/views/screens/auth_page.dart';
import 'package:campus_connect/views/screens/success_reset_page.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _forgetPass() async {
    if (_emailController.text.isEmpty ||
        !_emailController.text.contains("@")) {
      GlobalMethods.errorDialog(
          subtitle: 'Please enter a correct email address', context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.sendPasswordResetEmail(
            email: _emailController.text.toLowerCase());
        Fluttertoast.showToast(
          msg: "An email has been sent to your email address",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SuccessReset(),
        ));
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildTop()),
                
                Expanded(
                  flex: 4,
                  child: _buildBottom()),
                _buildLoginButton(),
              ],
            ),
            ButtonBackWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      child: Image.asset(
        'assets/logo.png',
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
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
          "Forgot Password",
          style: TextStyle(
              color: darkColor , fontSize: 28, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
        ),
        const SizedBox(height: 30),
        const Text(
          "Please, enter your email address, you will receive a link to create a new password via email",
          style: TextStyle(
              color: darkColor , fontSize: 16,  fontFamily: 'CrimsonText'),
        ),
        const SizedBox(height: 20),
        _buildGreyText("Email"),
        _buildInputField(_emailController),
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
          debugPrint("Email : ${_emailController.text}");
          _forgetPass();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: campuscolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0),),
          elevation: 20,
          shadowColor: campuscolor,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("SEND",style: const TextStyle(color: Colors.white,fontFamily: 'Roboto',fontSize: 16,fontWeight: FontWeight.w700)),
      ),
    );
  }
}