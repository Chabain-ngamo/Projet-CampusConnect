import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'dart:io';

const d_red = Color(0xFFDB3022);

class AddPublication extends StatefulWidget {
  //AddPublication({required this.productId});

  @override
  _AddPublicationState createState() => _AddPublicationState();
}

class _AddPublicationState extends State<AddPublication> {
  File? selectedImage;
  String? photoURL;
  final User? user = FirebaseAuth.instance.currentUser;

  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<String> uploadImage(File image) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String photoURL = await taskSnapshot.ref.getDownloadURL();
      return photoURL;
    } catch (error) {
      throw error;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    final publicationProvider = Provider.of<PublicationProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 155),
          child: Divider(
            thickness: 7,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Add your publication',
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: campuscolor,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.cancel_rounded,
                  color: campuscolor,
                ),
                onPressed: () {
                  _messageController.clear();
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextField(
                    controller: _messageController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Write a message...',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: campuscolor, 
                          width: 1.0, 
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromARGB(253, 255, 254, 254),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  setState(() {
                    selectedImage = File(result.files.single.path!);
                  });
                }
              },
              child: selectedImage != null
                  ? Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    )
                  : Image.asset(
                      photoURL ?? 'assets/gallery.png',
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.photo,
                color: campuscolor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(
                Icons.camera_alt,
                color: campuscolor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
  onPressed: () async {
    User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(user.uid).get();

    final userPhoto = userSnapshot['photo'];
    double nbLike = 0;
    double nbComment = 0;

    final publicationId = const Uuid().v4();

    try {
      if (_messageController.text.isNotEmpty && selectedImage != null) {
        String imageUrl = await uploadImage(selectedImage!);

        await FirebaseFirestore.instance
            .collection('publications')
            .doc(publicationId)
            .set({
          'publicationId': publicationId,
          'userId': user.uid,
          'userPhoto': userPhoto,
          'publiPhoto': imageUrl,
          'nbLike': nbLike,
          'nbComment': nbComment,
          'userName': user.displayName,
          'message': _messageController.text,
          'publicationDate': Timestamp.now(),
        });

        publicationProvider.fetchPublication();
        await Fluttertoast.showToast(
          msg: "Your publication has been added",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        // Afficher un message d'erreur si l'utilisateur n'a pas entré de message ou sélectionné d'image
        GlobalMethods.errorDialog(
          subtitle: "Please enter a message and select an image to publish",
          context: context,
        );
      }
    } catch (error) {
      GlobalMethods.errorDialog(
        subtitle: error.toString(),
        context: context,
      );
    } finally {
      //Navigator.pop(context);
    }
  }
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
    "POST",
    style: TextStyle(
        color: Colors.white,
        fontFamily: 'Roboto',
        fontSize: 16,
        fontWeight: FontWeight.w700),
  ),
),

        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
