import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/auth_page.dart';
import 'package:campus_connect/views/screens/edit_profil_page.dart';
import 'package:campus_connect/views/screens/meteo_page.dart';
import 'package:campus_connect/views/screens/notification_page.dart';
import 'package:campus_connect/views/screens/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final FirebaseAuth authInstance = FirebaseAuth.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  String? photoURL;
  String? userName, userEmail, userPromo;

  void _fetchUserPhoto() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        photoURL = userDoc.get('photo');
      });
    }
  }

  @override
  void initState() {
    _fetchUserPhoto();
    super.initState();
  }

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
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return const Text(
                    'Erreur de chargement',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  );
                }

                if (snapshot.hasData && snapshot.data!.exists) {
                  final userData = snapshot.data!.data();
                  final userName = userData?['name'] ?? 'Nom non disponible';
                  final userEmail =
                      userData?['email'] ?? 'Email non disponible';
                  final userPromo =
                      userData?['promo'] ?? 'Promotion non disponible';
                  return Column(
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
                                icon: const Icon(
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
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const SettingPage())));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Settings selected')),
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
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
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
                                        const Divider(
                                            color: Color.fromARGB(
                                                116, 158, 158, 158),
                                            thickness: 1),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const NotificationPage())));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      'Notifications selected')),
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
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
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
                                        const Divider(
                                            color: Color.fromARGB(
                                                116, 158, 158, 158),
                                            thickness: 1),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const MeteoPage())));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content:
                                                      Text('Meteo selected')),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'assets/icons_meteo.png',
                                                fit: BoxFit.cover,
                                                width: 28,
                                                height: 28,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
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
                                        const Divider(
                                            color: Color.fromARGB(
                                                116, 158, 158, 158),
                                            thickness: 1),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const EditProfilPage())));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content:
                                                      Text('Edit selected')),
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
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
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
                        height: 400,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  height: 370,
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
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                                border: Border.all(
                                                  color: campuscolor,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              25.0)),
                                                  child: photoURL != null
                                                      ? Image.network(
                                                          photoURL!,
                                                          fit: BoxFit.cover,
                                                          width: 70,
                                                          height: 70,
                                                        )
                                                      : Image.asset(
                                                          'assets/avatar.png',
                                                          fit: BoxFit.cover,
                                                          width: 70,
                                                          height: 70,
                                                        ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                width: 160,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  userName,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20,
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
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
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        campuscolor,
                                                                    fontSize:
                                                                        20,
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
                                        margin: const EdgeInsets.only(
                                            left: 35, bottom: 15),
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
                                          children: [
                                            const Text(
                                              'promotion ',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: campuscolor,
                                                fontFamily: 'CrimsonText',
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              userPromo,
                                              style: const TextStyle(
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
                                        margin: const EdgeInsets.only(
                                            left: 35, top: 5, bottom: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              userEmail,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontFamily: 'CrimsonText',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 160,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: const Color.fromARGB(
                                              255, 229, 228, 228),
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                title: const Text(
                                                  'Sign out ?',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: campuscolor,
                                                      fontSize: 20),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        backgroundColor:
                                                            campuscolor,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Non')),
                                                  ElevatedButton(
                                                    style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          campuscolor,
                                                    ),
                                                    onPressed: () async {
                                                      await authInstance
                                                          .signOut();
                                                      SharedPreferences prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await prefs
                                                          .remove('userId');
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AuthPage(),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text('Oui'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.logout,
                                              size: 20, color: Colors.white),
                                          label: Row(
                                            children: const [
                                              SizedBox(width: 10),
                                              Text(
                                                'Log Out',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: campuscolor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 20),
                                          ),
                                        ),
                                      )
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Text(
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
                                            children: const [
                                              Text(
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
                                            children: const [
                                              Text(
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
                            children:
                                List.generate(commentsList.length, (index) {
                              return Column(
                                children: [
                                  PubliCard(
                                    commentData: commentsList[index],
                                  ),
                                  if (index < commentsList.length - 1)
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Divider(
                                          color: Color.fromARGB(
                                              116, 158, 158, 158),
                                          thickness: 1),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  );
                }
                return const Center(
                  child: Text(
                    'Aucune donnée disponible',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                    ),
                  ),
                );
              })),
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
