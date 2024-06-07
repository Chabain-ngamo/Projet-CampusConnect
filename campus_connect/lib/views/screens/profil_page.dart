import 'package:campus_connect/controllers/publicationControllerP.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/auth_page.dart';
import 'package:campus_connect/views/screens/edit_profil_page.dart';
import 'package:campus_connect/views/screens/meteo_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:campus_connect/views/screens/notification_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_connect/views/screens/setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;
    return Scaffold(
        backgroundColor: colorB,
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
                      final userName =
                          userData?['name'] ?? 'Nom non disponible';
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.profile,
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 24,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  PopupMenuButton<int>(
                                    icon: Icon(
                                      Icons.more_horiz_outlined,
                                      color: color,
                                      size: 35,
                                    ),
                                    onSelected: (int result) {},
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
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .settings,
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w800,
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
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .notification,
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w800,
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
                                                      content: Text(
                                                          'Meteo selected')),
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
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .meteo,
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w800,
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
                                                      content: Text(
                                                          'Edit selected')),
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
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .edit,
                                                    style: TextStyle(
                                                      color: color,
                                                      fontSize: 16,
                                                      fontFamily: 'Roboto',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    color: colorB,
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
                                        color: colorB,
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
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: StreamBuilder<
                                                        DocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser
                                                              ?.uid)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          final userData =
                                                              snapshot.data
                                                                  ?.data();
                                                          final profileImageUrl =
                                                              userData?[
                                                                      'photo'] ??
                                                                  'default_image_url'; // Chemin par défaut de l'image si l'URL n'est pas disponible

                                                          return ClipRRect(
                                                            borderRadius:
                                                                const BorderRadius
                                                                        .all(
                                                                    Radius.circular(
                                                                        25.0)),
                                                            child: Image(
                                                              image: CachedNetworkImageProvider(
                                                                  profileImageUrl),
                                                              fit: BoxFit.cover,
                                                              width: 65,
                                                              height: 65,
                                                              errorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Icon(Icons
                                                                    .error); // Affiche une icône d'erreur en cas de problème de chargement de l'image
                                                              },
                                                            ),
                                                          );
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return Text(
                                                            'Error',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
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
                                                                          TextStyle(
                                                                        color:
                                                                            color,
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            'Roboto',
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
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .about_me,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: color,
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
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .promotion,
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
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    title: const Text(
                                                      'Sign out ?',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: campuscolor,
                                                          fontSize: 20),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    actions: [
                                                      ElevatedButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                campuscolor,
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Non')),
                                                      ElevatedButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              campuscolor,
                                                        ),
                                                        onPressed: () async {
                                                          await authInstance
                                                              .signOut();
                                                          SharedPreferences
                                                              prefs =
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
                                                        child:
                                                            const Text('Oui'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.logout,
                                                  size: 20,
                                                  color: Colors.white),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 20),
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  StreamBuilder<
                                                      QuerySnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'publications')
                                                        .where('userId',
                                                            isEqualTo:
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        final publicationCount =
                                                            snapshot.data?.docs
                                                                    .length ??
                                                                0;
                                                        return Text(
                                                          "$publicationCount",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                          'Error',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else {
                                                        return const CircularProgressIndicator();
                                                      }
                                                    },
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
                                                  StreamBuilder<
                                                      QuerySnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            'publications')
                                                        .where('userId',
                                                            isEqualTo:
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        num totalLikes = 0;
                                                        for (final doc
                                                            in snapshot
                                                                .data!.docs) {
                                                          final data =
                                                              doc.data();
                                                          final nbLike =
                                                              data['nbLike'] ??
                                                                  0;
                                                          totalLikes +=
                                                              nbLike.toInt();
                                                        }
                                                        return Text(
                                                          "$totalLikes",
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                          'Error: ${snapshot.error}',
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 24,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else {
                                                        return const CircularProgressIndicator();
                                                      }
                                                    },
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
                                                  StreamBuilder<
                                                      QuerySnapshot<
                                                          Map<String,
                                                              dynamic>>>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('comments')
                                                        .where('userId',
                                                            isEqualTo:
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser
                                                                    ?.uid)
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        final commentCount =
                                                            snapshot.data?.docs
                                                                    .length ??
                                                                0;
                                                        return Text(
                                                          "$commentCount",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 24,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return Text(
                                                          'Error',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        );
                                                      } else {
                                                        return const CircularProgressIndicator();
                                                      }
                                                    },
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
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.myPub,
                                  style: TextStyle(
                                    color: color,
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
                              decoration: BoxDecoration(
                                color: colorB,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: color,
                                    spreadRadius: 4,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                PublicationControllerP(),
                              ]),
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
