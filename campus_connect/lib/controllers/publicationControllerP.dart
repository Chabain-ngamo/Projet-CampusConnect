import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:campus_connect/views/screens/edit_publication.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PublicationControllerP extends StatefulWidget {
  const PublicationControllerP({super.key});

  @override
  State<PublicationControllerP> createState() => _PublicationControllerPState();
}

class _PublicationControllerPState extends State<PublicationControllerP> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _publicationsStream =
      FirebaseFirestore.instance
          .collection('publications')
          .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

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
            final publicationModel = snapshot.data!.docs[index].data();
            final message = publicationModel['message'];
            final publiPhoto = publicationModel['publiPhoto'];
            final nbLike = publicationModel['nbLike'];
            final publicationId = publicationModel['publicationId'];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PublicationPage(),
                    settings: RouteSettings(
                      arguments: publicationId,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20.0)),
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  publiPhoto,
                                ),
                                fit: BoxFit.cover,
                                width: 130,
                                height: 170,
                              )),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'NEW',
                                  style: const TextStyle(
                                    color: campuscolor,
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    onPressed: () => showModalBottomSheet(
                                          //enableDrag: false,
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(30))),
                                          context: context,
                                          builder: (context) => Container(
                                            decoration: BoxDecoration(
                                                color: colorB,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            30))),
                                            child: EditPublication(
                                                publicationId: publicationId),
                                          ),
                                        ),
                                    icon: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: campuscolor,
                                    )),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  color:colorB,
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          title: const Text(
                                            'Delete Post ?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: campuscolor,
                                                fontSize: 20),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: campuscolor,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Non')),
                                            ElevatedButton(
                                              style: TextButton.styleFrom(
                                                backgroundColor: campuscolor,
                                              ),
                                              onPressed: () async {
                                                try {
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'publications')
                                                      .doc(publicationId)
                                                      .delete();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Publication supprimée avec succès'),
                                                    ),
                                                  );
                                                } catch (error) {
                                                  // Gestion des erreurs
                                                  GlobalMethods.errorDialog(
                                                    subtitle: '$error',
                                                    context: context,
                                                  );
                                                }
                                              },
                                              child: const Text('Oui'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 28,
                                      color: campuscolor,
                                    ))
                              ],
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: 60,
                                width: 150,
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: color,
                                    fontFamily: 'CrimsonText',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
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
                                const SizedBox(width: 10),
                                Text(
                                  nbLike.toString(),
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
              ),
            );
          }),
        );
      },
    );
  }
}
