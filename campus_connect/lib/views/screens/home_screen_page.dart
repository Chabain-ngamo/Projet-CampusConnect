import 'package:campus_connect/controllers/publicationControllerH.dart';
import 'package:campus_connect/models/pulicationModel.dart';
import 'package:campus_connect/providers/publication_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({super.key});

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final List publicationList = [
    {
      'name': 'Duval',
      'message':
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein. A cet effet nous allons tous nous vêtir d’un vêtement rose.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '230',
      'comments': '12',
    },
    {
      'name': 'Chabain',
      'message':
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein. A cet effet nous allons tous nous vêtir d’un vêtement rose.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '192',
      'comments': '26',
    },
    {
      'name': 'Florent',
      'message':
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein. A cet effet nous allons tous nous vêtir d’un vêtement rose.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '50',
      'comments': '56',
    },
  ];

  @override
  void initState() {
    final publicationProvider = Provider.of<PublicationProvider>(context, listen: false);
    publicationProvider.fetchPublication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final publicationProvider = Provider.of<PublicationProvider>(context);
    List<PublicationModel> allPublications = publicationProvider.getPublication;


    return Scaffold(
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
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.asset(
                    'assets/profil.jpeg',
                    fit: BoxFit.cover,
                    width: 55,
                    height: 55,
                  ),
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
              children: const [
                Text(
                  "Explore today's",
                  style: TextStyle(
                      color: Colors.black,
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
