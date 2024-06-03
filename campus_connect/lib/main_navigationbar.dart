import 'dart:io';

import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/chat_page.dart';
import 'package:campus_connect/views/screens/home_screen_page.dart';
import 'package:campus_connect/views/screens/profil_page.dart';
import 'package:campus_connect/views/screens/search_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  @override
  _MainNavigationBarState createState() => _MainNavigationBarState();
}

class _MainNavigationBarState extends State<MainNavigationBar> {
  File? selectedImage;
  int _pageIndex = 0;
  TextEditingController _messageController = TextEditingController();

  List<Widget> _pages = [
    const HomeScreenPage(),
    const ChatPage(),
    const SearchPage(),
    const ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    selectedImage = null;
  }

  /*Future<String> uploadImage(File image) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now().toString()}');
      UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String photoURL = await taskSnapshot.ref.getDownloadURL();
      return photoURL;
    } catch (error) {
      throw error;
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 235, 235),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(child: _pages[_pageIndex]),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: _pageIndex,
                  onTap: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  backgroundColor: Colors.white,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: campuscolor,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.manage_search_outlined),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: (MediaQuery.of(context).size.width - 60) / 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: 500,
                          height: 350,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.cancel_rounded,
                                      color: campuscolor,
                                    ),
                                    onPressed: () {},
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: TextField(
                                        controller: _messageController,
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          hintText: 'Write a message...',
                                          hintStyle: TextStyle(fontSize: 16),
                                          border: InputBorder
                                              .none, // Remove the line below hintText
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 500,
                                height: 150,
                                decoration: BoxDecoration(
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
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );
                                    if (result != null) {
                                      setState(() {
                                        selectedImage =
                                            File(result.files.single.path!);
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
                                      : Icon(
                                          Icons.add_photo_alternate,
                                          color: Color.fromARGB(
                                              130, 158, 158, 158),
                                          size: 60,
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
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
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
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const CircleAvatar(
                  radius: 28,
                  backgroundColor: campuscolor,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
