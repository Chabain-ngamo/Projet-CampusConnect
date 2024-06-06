import 'dart:io';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late Size mediaSize;
  File? selectedImage;
  String? photoURL;
  final User? user = FirebaseAuth.instance.currentUser;
  final _userController = TextEditingController();
  final _promotionController = TextEditingController();

  @override
  void dispose() {
    _userController.dispose();
    _promotionController.dispose();
    super.dispose();
  }

  void _fetchUserPhoto() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        photoURL = userDoc.get('photo');
        _userController.text = user.displayName ?? '';
      });
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      String fileName = '${FirebaseAuth.instance.currentUser!.uid}.jpg';
      Reference storageReference =
          FirebaseStorage.instance.ref().child('profileImages/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);
      await uploadTask;
      String downloadURL = await storageReference.getDownloadURL();
      print('Image uploaded to $downloadURL');
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }

  @override
  void initState() {
    getUserData();
    _fetchUserPhoto();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      //_isLoading = true;
    });
    if (user == null) {
      setState(() {
        //_isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _userController.text = userDoc.get('name');
        _promotionController.text = userDoc.get('promo');
        photoURL = userDoc.get('photo');
      }
    } catch (error) {
      setState(() {
        //_isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        // _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Container(
      decoration: const BoxDecoration(color: backColor),
      child: Scaffold(
        backgroundColor: colorB,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: mediaSize.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                "Update Profile",
                                style: TextStyle(
                                    color: color,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto'),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                  child: Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: campuscolor, width: 4.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: selectedImage != null
                                            ? Image.file(
                                                selectedImage!,
                                                fit: BoxFit.cover,
                                                width: 150,
                                                height: 150,
                                              )
                                            : (photoURL != null &&
                                                    photoURL!
                                                        .startsWith('http'))
                                                ? Image.network(
                                                    photoURL!,
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Icon(
                                                      Icons.error,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : Image.asset(
                                                    'assets/avatar.png',
                                                    fit: BoxFit.cover,
                                                    width: 150,
                                                    height: 150,
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
                                        icon: const Icon(Icons.edit,
                                            color: campuscolor, size: 18),
                                        onPressed: () async {
                                          // Implémentez la logique de modification de la photo de profil
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      type: FileType.image);
                                          if (result != null) {
                                            setState(() {
                                              selectedImage = File(
                                                  result.files.single.path!);
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                              const SizedBox(height: 60),
                              _buildGreyText("Name"),
                              TextField(
                                controller: _userController,
                                decoration: const InputDecoration(
                                    iconColor: campuscolor),
                              ),
                              const SizedBox(height: 25),
                              _buildGreyText("Promotion"),
                              TextField(
                                controller: _promotionController,
                                decoration: const InputDecoration(
                                    iconColor: campuscolor),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user == null)
                            throw Exception("User not logged in");

                          String? photoURLL = photoURL;

                          if (selectedImage != null) {
                            photoURLL = await uploadImage(selectedImage!);
                          }

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .update({
                            'photo': photoURLL,
                            'name': _userController.text,
                            'promo': _promotionController.text,
                          });

                          await user.updatePhotoURL(photoURLL);
                          await user.updateDisplayName(_userController.text);
                          await user.reload();
                          user = FirebaseAuth.instance.currentUser;

                          Fluttertoast.showToast(
                            msg: "Your information has been saved",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );

                          if (mounted) {
                            setState(() {
                              photoURL = photoURLL;
                            });
                          }
                        } catch (error) {
                          print('Error updating profile: $error');
                          Fluttertoast.showToast(
                            msg: "Failed to update profile: $error",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                        } finally {
                          if (mounted) {
                            setState(() {});
                          }
                        }

                        debugPrint("User : ${_userController.text}");
                        debugPrint("promotion : ${_promotionController.text}");
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
                        "UPDATE",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Roboto'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonBackWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: campuscolor,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          fontFamily: 'Roboto'),
    );
  }
}
