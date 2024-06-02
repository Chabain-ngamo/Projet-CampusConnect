import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late Size mediaSize;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController promotionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: backColor
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  _buildBottom(),
                  _buildUpdateButton()
                ],
              ),
            ),
            ButtonBackWidget()
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Update Profile",
          style: TextStyle(
              color: darkColor, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        
        ),
        const SizedBox(height: 20),
        Center(child: _buildProfilePicture()),
        const SizedBox(height: 60),
        _buildGreyText("Name"),
        _buildInputField(userController),
        const SizedBox(height: 25),
        _buildGreyText("Email"),
        _buildInputField(emailController),
        const SizedBox(height: 25),
        _buildGreyText("Promotion"),
        _buildInputField(promotionController),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: campuscolor, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto'),
    );
  }

  Widget _buildInputField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        iconColor: campuscolor
      ),
    );
  }

  Widget _buildUpdateButton() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ElevatedButton(
        onPressed: () {
          debugPrint("User : ${userController.text}");
          debugPrint("Email : ${emailController.text}");
          debugPrint("promotion : ${promotionController.text}");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: campuscolor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0),),
          elevation: 20,
          shadowColor: campuscolor,
          minimumSize: const Size.fromHeight(60),
        ),
        child: const Text("UPDATE", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Roboto'),),
      ),
    );
  }

  Widget _buildProfilePicture() {
  return Stack(
    children: [
      Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: campuscolor, width: 4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: const DecorationImage(
                image: AssetImage('assets/profil.jpeg'), // Remplacez par l'image de l'utilisateur
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 8,
        right: 8,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.8),
          ),
          child: IconButton(
            icon: const Icon(Icons.edit, color: campuscolor, size: 18),
            onPressed: () {
              // Implémentez la logique de modification de la photo de profil
            },
          ),
        ),
      ),
    ],
  );
}



}
 