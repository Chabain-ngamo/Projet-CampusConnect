import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/edit_profil_page.dart';
import 'package:campus_connect/views/screens/notification_page.dart';
import 'package:campus_connect/views/screens/setting_page.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:campus_connect/views/widgets/likesW.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> commentsList = [
      {
        'name': 'JPO',
        'description': 'Au coeur d’un évenement mémorable',
        'photo': 'assets/profil.jpeg',
        'likes': '2.1k',
      },
      {
        'name': 'JPO',
        'description': 'Au coeur d’un évenement mémorable',
        'photo': 'assets/profil.jpeg',
        'likes': '2.1k',
      },
      {
        'name': 'JPO',
        'description': 'Au coeur d’un évenement mémorable',
        'photo': 'assets/profil.jpeg',
        'likes': '2.1k',
      },
    ];

    return Scaffold(
        body: Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Profile",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PopupMenuButton<int>(
                      icon: Icon(
                        Icons.more_horiz_outlined,
                        color: Colors.black,
                        size: 35,
                      ),
                      onSelected: (int result) {
                        /*if (result == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Ok selected')),
                          );
                        }*/
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 0,
                          child: Column(
                            children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: ((context) => SettingPage()))
                              );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Settings selected')),
                            );
                          },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons8_setting.png',
                                  fit: BoxFit.cover,
                                  width: 28,
                                  height: 28,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                            Divider(
                              color: Color.fromARGB(116, 158, 158, 158),
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: ((context) => NotificationPage()))
                              );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Notifications selected')),
                            );
                          },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons8_notification.png',
                                  fit: BoxFit.cover,
                                  width: 28,
                                  height: 28,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                           Divider(
                              color: Color.fromARGB(116, 158, 158, 158),
                              thickness: 1),
                          InkWell(
                            onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Meteo selected')),
                            );
                            Navigator.of(context).pop(); // Close the popup
                          },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons_meteo.png',
                                  fit: BoxFit.cover,
                                  width: 28,
                                  height: 28,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'Meteo',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                              color: Color.fromARGB(116, 158, 158, 158),
                              thickness: 1),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: ((context) => EditProfilPage()))
                              );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Edit selected')),
                            );
                          },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons_edit.png',
                                  fit: BoxFit.cover,
                                  width: 28,
                                  height: 28,
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                           
                            ],
                          ),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 380,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 4,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 35),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      border: Border.all(
                                        color: campuscolor,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25.0)),
                                        child: Image.asset(
                                          'assets/profil.jpeg',
                                          fit: BoxFit.cover,
                                          width: 70,
                                          height: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Container(
                                      width: 160,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        'Chabain Ngamo',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: const [
                                                      Text(
                                                        'Etudiant',
                                                        style: TextStyle(
                                                          color: campuscolor,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              'CrimsonText',
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 35, bottom: 20),
                              child: Row(
                                children: const [
                                  Text(
                                    'About me',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 35,
                              ),
                              child: Row(
                                children: const [
                                  Text(
                                    'promotion X2025',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: campuscolor,
                                      fontFamily: 'CrimsonText',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 5),
                              child: Row(
                                children: const [
                                  Text(
                                    'chabain.ngamo@2025.ucac-icam.com',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontFamily: 'CrimsonText',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 1,
                    left: 65,
                    child: Container(
                      height: 86,
                      width: 260,
                      decoration: BoxDecoration(
                        color: campuscolor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 4,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '33',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Publications',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'CrimsonText',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '50',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Likes',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'CrimsonText',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      '230',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'CrimsonText',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text(
                    "My Publications",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: fondcolor,
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(commentsList.length, (index) {
                    return Column(
                      children: [
                        PubliCard(
                          commentData: commentsList[index],
                        ),
                        if (index < commentsList.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                                color: Color.fromARGB(116, 158, 158, 158),
                                thickness: 1),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    ]));
  }
}

class PubliCard extends StatelessWidget {
  final Map<String, String> commentData;

  PubliCard({
    required this.commentData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              child: Image.asset(
                commentData['photo']!,
                fit: BoxFit.cover,
                width: 130,
                height: 170,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentData['name']!,
                style: const TextStyle(
                  color: campuscolor,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 80,
                width: 150,
                child: Text(
                  commentData['description']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'CrimsonText',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.grey,
                    size: 26,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    commentData['likes']!,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontFamily: 'CrimsonText',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
