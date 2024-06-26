import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:campus_connect/views/widgets/likesW.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CommentController extends StatefulWidget {
  final String publicationId;
  const CommentController({Key? key, required this.publicationId}) : super(key: key);

  @override
  State<CommentController> createState() => _CommentControllerState(publicationId: publicationId);
}

class _CommentControllerState extends State<CommentController> {
  final String publicationId;
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _publicationsStream; // Déclaration de _publicationsStream sans l'initialiser


  _CommentControllerState({required this.publicationId}) {
    // Initialisation de _publicationsStream dans le constructeur
    _publicationsStream = FirebaseFirestore.instance
        .collection('comments')
        .where('publicationId', isEqualTo: publicationId) 
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
    //final publicationModel = Provider.of<PublicationModel>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _publicationsStream,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.cyan),
          );
        }

        return ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(snapshot.data!.docs.length, (index) {
            final commentModel = snapshot.data!.docs[index].data();
            final message = commentModel['message'];
            final userPhoto = commentModel['userPhoto'];
            final nbLike = commentModel['nbLike'];
            final userName = commentModel['userName'];
            final commentDate = commentModel['commentDate'];
            // Convertir Timestamp en DateTime
            DateTime dateTime = commentDate.toDate();
            // Formatter la date
            String formattedDate = DateFormat('hh:mm').format(dateTime);

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        child: Image(
                          image: CachedNetworkImageProvider(
                            userPhoto,
                          ),
                          fit: BoxFit.cover,
                          width: 45,
                          height: 45,
                        )),
                    title: Padding(
                      padding: const EdgeInsets.only(right: 10,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userName,
                            style:  TextStyle(
                              color: color,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: 'CrimsonText',
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
                              message,
                              style:  TextStyle(
                                fontSize: 16,
                                color: color,
                                fontFamily: 'CrimsonText',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Positioned(right: 1, bottom: 1, child: LikeButton())
                      ],
                    ),
                  ),
                ),
                if (index < snapshot.data!.docs.length - 1)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
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
    );
  }
}
