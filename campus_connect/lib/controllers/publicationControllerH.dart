import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_connect/views/screens/publication_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class PublicationControllerH extends StatefulWidget {
  const PublicationControllerH({super.key});

  @override
  State<PublicationControllerH> createState() => _PublicationControllerHState();
}

class _PublicationControllerHState extends State<PublicationControllerH> {
  @override
  Widget build(BuildContext context) {
    final publicationModel = Provider.of<PublicationModel>(context);
    final publicationCollection =
        FirebaseFirestore.instance.collection('publications');
    // Convertir Timestamp en DateTime
    DateTime dateTime = publicationModel.publicationDate.toDate();

    // Formatter la date
    String formattedDate = DateFormat('dd MMMM yyyy \'at\' h:mm a').format(dateTime);
    String monthDate = DateFormat('MMMM').format(dateTime);
    String daysDate = DateFormat('dd').format(dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PublicationPage(),
              settings: RouteSettings(
                arguments: publicationModel.publicationId,
              ),
            ),
          );
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 500,
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
        child: Stack(children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      child: Image(
                        image: CachedNetworkImageProvider(
                          publicationModel.userPhoto,
                        ),
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                publicationModel.userName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontFamily: 'CrimsonText',
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 330,
                      child: Text(
                        publicationModel.message,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'CrimsonText',
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 320,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    /*image: NetworkImage(
                      publicationModel.publiPhoto,
                    ),*/
                    image: CachedNetworkImageProvider(
                      publicationModel.publiPhoto,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: fondcolor,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.thumb_up,
                        color: campuscolor,
                        size: 20,
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: publicationCollection
                            .doc(publicationModel.publicationId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final publicationData = snapshot.data?.data();
                            final nbLike = publicationData?['nbLike'] ?? 0;
                            return Text(
                              "$nbLike",
                              style: const TextStyle(
                                fontSize: 14,
                                color: campuscolor,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: campuscolor,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(48, 158, 158, 158),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.message,
                        color: Colors.grey,
                        size: 20,
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: publicationCollection
                            .doc(publicationModel.publicationId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final publicationData = snapshot.data?.data();
                            final nbComment = publicationData?['nbComment'] ?? 0;
                            return Text(
                              "$nbComment",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w800,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 15,
            child: Container(
              width: 65,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: fondcolor,
                    spreadRadius: 4,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children:  [
                    Text(
                      daysDate,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      monthDate,
                      style: TextStyle(
                        fontSize: 18,
                        color: campuscolor,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
