import 'package:campus_connect/main_navigationbar.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:campus_connect/services/loading_manager.dart';
import 'package:campus_connect/views/screens/reset_pass_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus_connect/views/screens/success_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Size mediaSize;
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = TextEditingController();
  final _promoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool isSignUp = false;
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _userFocusNode = FocusNode();
  final _promoFocusNode = FocusNode();
  bool _isPasswordVisible = false;

  void _toggleWidget(bool signUp) {
    setState(() {
      isSignUp = signUp;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _userFocusNode.dispose();
    _promoFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(_userController.text);
        user.reload();
        const String defaultPhotoURL = 'https://firebasestorage.googleapis.com/v0/b/campus-connect-ea94f.appspot.com/o/images%2F2024-06-05%2009%3A01%3A14.463241?alt=media&token=7ecbcc54-7244-450d-89a6-98fcfd5cb07d';
        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          'id': _uid,
          'name': _userController.text,
          'promo': _promoController.text,
          'email': _emailController.text.toLowerCase(),
          'password': _passwordController.text,
          'userLike': [],
          'photo': defaultPhotoURL,
          'createdAt': Timestamp.now(),
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => SuccessSignUp(),
        ));
        print('Succefully registered');
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

  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());
        User? user = authInstance.currentUser;
        String userId = user!.uid;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userId', userId);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainNavigationBar(),
          ),
        );
        print('Succefully logged in');
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
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                _buildTop(),
                _buildButton(),
              ],
            ),
          ),
        ]),
      ),
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
                            color: isSignUp
                                ? Color.fromARGB(124, 255, 255, 255)
                                : Colors.white,
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
                            color: isSignUp
                                ? Colors.white
                                : Color.fromARGB(124, 255, 255, 255),
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
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildGreyText1("Sign in with your account"),
                const SizedBox(height: 30),
                _buildGreyText1("Email"),
                _buildInputField1(_emailController,_emailFocusNode,onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_passFocusNode),),
                const SizedBox(height: 30),
                _buildGreyText1("Password"),
                _buildInputField1(_passwordController, isPassword: true,_passFocusNode),
                const SizedBox(height: 40),
                _buildLoginButton1(),
                const SizedBox(height: 10),
                _buildRememberForgot1(),
                const SizedBox(height: 20),
              ],
            )),
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

  Widget _buildInputField1(TextEditingController controller, FocusNode focusNode,
      {bool isPassword = false, VoidCallback? onEditingComplete}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : const Icon(Icons.done),
      ),
      obscureText: isPassword && !_isPasswordVisible,
      onEditingComplete: onEditingComplete,
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
        debugPrint("Email : ${_emailController.text}");
        debugPrint("Password : ${_passwordController.text}");
        _submitFormOnLogin();
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
        Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                _buildGreyText("Username"),
                _buildInputField(
                  _userController,
                  _userFocusNode,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_promoFocusNode),
                ),
                const SizedBox(height: 20),
                _buildGreyText("Promotion"),
                _buildInputField(
                  _promoController,
                  _promoFocusNode,
                  onEditingComplete: () =>
                      FocusScope.of(context).requestFocus(_emailFocusNode),
                ),
                const SizedBox(height: 20),
                _buildGreyText("Email"),
                _buildInputField(_emailController, _emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passFocusNode)),
                const SizedBox(height: 20),
                _buildGreyText("Password"),
                _buildInputField(
                    _passwordController, isPassword: true, _passFocusNode),
                const SizedBox(height: 50),
              ],
            )),
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

  Widget _buildInputField(TextEditingController controller, FocusNode focusNode,
      {bool isPassword = false, VoidCallback? onEditingComplete}) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : const Icon(Icons.done),
      ),
      obscureText: isPassword && !_isPasswordVisible,
      onEditingComplete: onEditingComplete,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("User : ${_userController.text}");
        debugPrint("Promo : ${_promoController.text}");
        debugPrint("Email : ${_emailController.text}");
        debugPrint("Password : ${_passwordController.text}");
        _submitFormOnRegister();
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
