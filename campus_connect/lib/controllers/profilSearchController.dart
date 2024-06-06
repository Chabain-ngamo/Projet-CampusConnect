import 'package:campus_connect/models/userModel.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    return Container(
      margin: const EdgeInsets.all(10),
      height: 180,
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
                                    Text(
                                      '10',
                                      style: const TextStyle(
                                        color: Colors.black,
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
                                    Text(
                                      '20',
                                      style: const TextStyle(
                                        color: Colors.black,
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
                                    Text(
                                      '15',
                                      style: const TextStyle(
                                        color: Colors.black,
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
                                    /*Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) => ChatDetailPage()))
                                    );*/
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
                    style: const TextStyle(
                      fontSize: 20,
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
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Text(
                    'promotion ',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: 'CrimsonText',
                    ),
                  ),
                  Text(
                    userModel.userPromo,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
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
