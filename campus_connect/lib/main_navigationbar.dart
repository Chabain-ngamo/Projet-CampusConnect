import 'dart:io';

import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/add_publication.dart';
import 'package:campus_connect/views/screens/chat_page.dart';
import 'package:campus_connect/views/screens/home_screen_page.dart';
import 'package:campus_connect/views/screens/profil_page.dart';
import 'package:campus_connect/views/screens/search_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
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
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

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
                  backgroundColor: colorB,
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
                onTap: () => showModalBottomSheet(
                  //enableDrag: false,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  context: context,
                  builder: (context) => Container(
                    decoration: BoxDecoration(
                        color: colorB,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: AddPublication(),
                  ),
                ),
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
