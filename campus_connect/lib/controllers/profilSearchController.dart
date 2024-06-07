import 'package:campus_connect/models/userModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_connect/views/screens/chat_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilSearchController extends StatefulWidget {
  const ProfilSearchController({super.key});

  @override
  State<ProfilSearchController> createState() => _ProfilSearchControllerState();
}

class _ProfilSearchControllerState extends State<ProfilSearchController> {
  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Container(
      margin: const EdgeInsets.all(10),
      height: 180,
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
      child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      child: Image(
                        image: CachedNetworkImageProvider(
                          userModel.userPhoto,
                        ),
                        fit: BoxFit.cover,
                        width: 65,
                        height: 65,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 250,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    StreamBuilder<
                                        QuerySnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection('publications')
                                          .where('userId',
                                              isEqualTo: userModel.userId)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final publicationCount =
                                              snapshot.data?.docs.length ?? 0;
                                          return Text(
                                            "$publicationCount",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: color,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    /*Text(
                                      '10',
                                      style:  TextStyle(
                                        color: color,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),*/
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Publications',
                                      style: TextStyle(
                                        color: Colors.grey,
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
                                        QuerySnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection('publications')
                                          .where('userId',
                                              isEqualTo: userModel.userId)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          num totalLikes = 0;
                                          for (final doc
                                              in snapshot.data!.docs) {
                                            final data = doc.data();
                                            final nbLike = data['nbLike'] ?? 0;
                                            totalLikes += nbLike.toInt();
                                          }
                                          return Text(
                                            "$totalLikes",
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 24,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error: ${snapshot.error}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    /*Text(
                                      '20',
                                      style:  TextStyle(
                                        color: color,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),*/
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Likes',
                                      style: TextStyle(
                                        color: Colors.grey,
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
                                        QuerySnapshot<Map<String, dynamic>>>(
                                      stream: FirebaseFirestore.instance
                                          .collection('comments')
                                          .where('userId',
                                              isEqualTo: userModel.userId)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final commentCount =
                                              snapshot.data?.docs.length ?? 0;
                                          return Text(
                                            "$commentCount",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: color,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Text(
                                            'Error',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontFamily: 'Roboto',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          );
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                    /*Text(
                                      '15',
                                      style:  TextStyle(
                                        color: color,
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),*/
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Text(
                                      'Comments',
                                      style: TextStyle(
                                        color: Colors.grey,
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 20),
                              child: SizedBox(
                                height: 35,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final currentUserId =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    final otherUserId = userModel.userId;
                                    final chatId =
                                        currentUserId.compareTo(otherUserId) < 0
                                            ? '$currentUserId\_$otherUserId'
                                            : '$otherUserId\_$currentUserId';

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: ((context) => ChatDetailPage(
                                            chatId: chatId,
                                            otherUserName:
                                                userModel.userName,
                                            otherUserPhotoUrl:
                                                userModel.userPhoto)),
                                      ),
                                    );

                                    // Ajouter le document dans la collection "messages"
                                    FirebaseFirestore.instance
                                        .collection('messages')
                                        .doc(chatId)
                                        .set({
                                      'users': [currentUserId, otherUserId],
                                      'createdAt': FieldValue.serverTimestamp(),
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: campuscolor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: const Text("Message",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontFamily: 'CrimsonText',
                                      )),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              child: Row(
                children: [
                  Text(
                    userModel.userName,
                    style: TextStyle(
                      fontSize: 20,
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
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'promotion ',
                    style: TextStyle(
                      fontSize: 20,
                      color: color,
                      fontFamily: 'CrimsonText',
                    ),
                  ),
                  Text(
                    userModel.userPromo,
                    style: TextStyle(
                      fontSize: 20,
                      color: color,
                      fontFamily: 'CrimsonText',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
