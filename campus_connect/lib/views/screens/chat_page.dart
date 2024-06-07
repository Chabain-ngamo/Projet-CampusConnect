import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/chat_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    final currentUser = _auth.currentUser;
    return Scaffold(
      backgroundColor: colorB,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 70),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children:  [
                      Text(
                        AppLocalizations.of(context)!.chat,
                        style: TextStyle(
                          color: color,
                          fontSize: 26,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorB,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('users')
                          .where('id', isNotEqualTo: currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final users = snapshot.data!.docs;
                        return Column(
                          children: List.generate(users.length, (index) {
                            final user = users[index];
                            final userData =
                                user.data() as Map<String, dynamic>;
                            return Column(
                              children: [
                                InterlocuteurCard(
                                  InterlocuteurData: {
                                    'id': userData['id'],
                                    'name': userData['name'],
                                    'promo': userData['promo'],
                                    'photo': userData['photo'],
                                  },
                                ),
                                if (index < users.length - 1)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Divider(
                                      color: Color.fromARGB(116, 158, 158, 158),
                                      thickness: 1,
                                    ),
                                  ),
                              ],
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InterlocuteurCard extends StatelessWidget {
  final Map<String, dynamic> InterlocuteurData;

  InterlocuteurCard({
    required this.InterlocuteurData,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;
    return GestureDetector(
      onTap: () {
        final currentUserId = FirebaseAuth.instance.currentUser!.uid;
        final otherUserId = InterlocuteurData['id'];
        final chatId = currentUserId.compareTo(otherUserId) < 0
            ? '$currentUserId\_$otherUserId'
            : '$otherUserId\_$currentUserId';

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => ChatDetailPage(chatId: chatId, otherUserName: InterlocuteurData['name'], otherUserPhotoUrl: InterlocuteurData['photo'])),
          ),
        );

        // Ajouter le document dans la collection "messages"
        FirebaseFirestore.instance.collection('messages').doc(chatId).set({
          'users': [currentUserId, otherUserId],
          'createdAt': FieldValue.serverTimestamp(),
        });
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Image(
            image: CachedNetworkImageProvider(
              InterlocuteurData['photo'],
            ),
            fit: BoxFit.cover,
            width: 45,
            height: 45,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                InterlocuteurData['name'],
                style:  TextStyle(
                  color: color,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        subtitle: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  InterlocuteurData['promo'],
                  style:  TextStyle(
                    fontSize: 16,
                    color: color,
                    fontFamily: 'CrimsonText',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
