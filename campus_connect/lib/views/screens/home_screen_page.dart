import 'package:campus_connect/controllers/publicationControllerH.dart';
import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  void initState() {
    final publicationProvider =
        Provider.of<PublicationProvider>(context, listen: false);
    publicationProvider.fetchPublication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final publicationProvider = Provider.of<PublicationProvider>(context);
    List<PublicationModel> allPublications = publicationProvider.getPublication;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Scaffold(
        backgroundColor: colorB,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 80,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final userData = snapshot.data?.data();
                          final profileImageUrl = userData?['photo'] ??
                              'default_image_url'; // Chemin par défaut de l'image si l'URL n'est pas disponible

                          return ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            child: Image(
                              image:
                                  CachedNetworkImageProvider(profileImageUrl),
                              fit: BoxFit.cover,
                              width: 55,
                              height: 55,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons
                                    .error); // Affiche une icône d'erreur en cas de problème de chargement de l'image
                              },
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
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        size: 35,
                        color: campuscolor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      //AppLocalizations.of(context)!.settings
                      AppLocalizations.of(context)!.explore,
                      style: TextStyle(
                          color: color,
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allPublications.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: allPublications[index],
                    child: const PublicationControllerH(),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ));
  }
}
