import 'dart:math' as math;
import 'package:campus_connect/controllers/commentController.dart';
import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/providers/like_provider.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/services/global_methods.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_connect/views/widgets/likesW.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class PublicationPage extends StatefulWidget {
  static const String routeName = '/publicationPage';
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  late PublicationModel getCurrPublication;
  final _messageController = TextEditingController();
  bool isLiked = false;
  bool? _islikelist;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final publicationId = ModalRoute.of(context)!.settings.arguments as String;
    final publicationProvider = Provider.of<PublicationProvider>(context);
    final likeProvider = Provider.of<LikeProvider>(context);
    final publicationCollection =
        FirebaseFirestore.instance.collection('publications');
    getCurrPublication = publicationProvider.findPubById(publicationId);
    _islikelist =
        likeProvider.getLikeItems.containsKey(getCurrPublication.publicationId);

    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;
    // Convertir Timestamp en DateTime
    DateTime dateTime = getCurrPublication.publicationDate.toDate();

    // Formatter la date
    String formattedDate =
        DateFormat('dd MMMM yyyy \'at\' h:mm a').format(dateTime);

    return Scaffold(
      backgroundColor: colorB,
        body: Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    child: Image(
                      image: CachedNetworkImageProvider(
                        getCurrPublication.userPhoto,
                      ),
                      fit: BoxFit.cover,
                      width: 55,
                      height: 55,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 260,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              getCurrPublication.userName,
                              style: TextStyle(
                                color: color,
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
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
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
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    getCurrPublication.publiPhoto,
                  ),
                  /*image: AssetImage(
                    'assets/theme3.png',
                  ),*/
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              height: 100,
              child: Text(
                getCurrPublication.message,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                  fontFamily: 'CrimsonText',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children:  [
                  Text(
                    AppLocalizations.of(context)!.comment,
                    style: TextStyle(
                      color: color,
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                decoration:  BoxDecoration(
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
                child: Column(children: [
                  CommentController(publicationId: publicationId)
                ]),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 65,
              margin: const EdgeInsets.only(top: 8),
              width: MediaQuery.of(context).size.width * 0.89,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: campuscolor,
                      ),
                      onPressed: () {
                        _messageController.clear();
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Enter your comment here...',
                            hintStyle: TextStyle(fontSize: 16),
                            border: InputBorder
                                .none, // Remove the line below hintText
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          FirebaseFirestore firestore =
                              FirebaseFirestore.instance;
                          DocumentSnapshot userSnapshot = await firestore
                              .collection('users')
                              .doc(user.uid)
                              .get();

                          final userPhoto = userSnapshot['photo'];
                          double nbLike = 0;
                          double nbComment = 0;

                          final commentId = const Uuid().v4();

                          try {
                            await FirebaseFirestore.instance
                                .collection('comments')
                                .doc(commentId)
                                .set({
                              'commentId': commentId,
                              'publicationId': publicationId,
                              'userId': user.uid,
                              'userPhoto': userPhoto,
                              'nbLike': nbLike,
                              'userName': user.displayName,
                              'message': _messageController.text,
                              'commentDate': Timestamp.now(),
                            });
                            _messageController.clear();
                            //publicationProvider.fetchPublication();
                            await Fluttertoast.showToast(
                              msg: "Your comment has been added",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                            // Incrémenter la valeur de nbComment dans la publication
                            DocumentSnapshot publicationSnapshot =
                                await FirebaseFirestore.instance
                                    .collection('publications')
                                    .doc(publicationId)
                                    .get();
                            int currentNbComment =
                                publicationSnapshot['nbComment'].toInt();
                            await FirebaseFirestore.instance
                                .collection('publications')
                                .doc(publicationId)
                                .update({
                              'nbComment': currentNbComment + 1,
                            });
                          } catch (error) {
                            GlobalMethods.errorDialog(
                              subtitle: error.toString(),
                              context: context,
                            );
                          } finally {
                            //Navigator.pop(context);
                          }
                        }
                      },
                      icon: Transform.rotate(
                        angle: -math.pi / 5, // Angle de rotation
                        child: const Icon(
                          Icons.send,
                          size: 28,
                          color: campuscolor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      ButtonBackWidget(),
      Positioned(
        bottom: 90,
        right: 20,
        child: GestureDetector(
          onTap: () async {
            setState(() {
              loading = true;
            });
            try {
              final User? user = authInstance.currentUser;

              if (user == null) {
                GlobalMethods.errorDialog(
                    subtitle: 'No user found, Please login first',
                    context: context);
                return;
              }
              if (_islikelist == false && _islikelist != null) {
                await GlobalMethods.addToLikelist(
                    publicationId: publicationId, context: context);
              } else {
                await likeProvider.removeOneItem(
                    likeId: likeProvider
                        .getLikeItems[getCurrPublication.publicationId]!.id,
                    publicationId: publicationId);
              }
              await likeProvider.fetchLikelist();
              setState(() {
                loading = false;
              });
            } catch (error) {
              GlobalMethods.errorDialog(subtitle: '$error', context: context);
            } finally {
              setState(() {
                loading = false;
              });
            }
          },
          child: loading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator()),
                )
              : Container(
                  height: 55,
                  width: 110,
                  decoration: BoxDecoration(
                    color: _islikelist != null && _islikelist == true
                        ? campuscolor
                        : Colors.grey,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.thumb_up_alt_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: publicationCollection
                            .doc(publicationId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final publicationData = snapshot.data?.data();
                            final nbLikes = publicationData?['nbLike'] ?? 0;
                            return Text(
                              "$nbLikes",
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'CrimsonText',
                                fontWeight: FontWeight.w400,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'CrimsonText',
                                fontWeight: FontWeight.w400,
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
        ),
      )
    ]));
  }
}
