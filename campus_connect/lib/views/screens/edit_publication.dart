import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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

class EditPublication extends StatefulWidget {
  final String publicationId;
  EditPublication({required this.publicationId});

  @override
  _EditPublicationState createState() => _EditPublicationState();
}

class _EditPublicationState extends State<EditPublication> {
  File? selectedImage;
  String? photoURL;
  final User? user = FirebaseAuth.instance.currentUser;

  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserData();
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

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('publications')
          .where('publicationId', isEqualTo: widget.publicationId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot userDoc = querySnapshot.docs.first;
        _messageController.text = userDoc.get('message');
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
          'Update your publication',
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
                    maxLines: 10,
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
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () async {
              try {

            await FirebaseFirestore.instance
                .collection('publications')
                .doc(widget.publicationId)
                .update({
              'message': _messageController.text,
            });

            Fluttertoast.showToast(
              msg: "Your post has been saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );

            if (mounted) {
              setState(() {
                
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
              "UPDATE POST",
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
