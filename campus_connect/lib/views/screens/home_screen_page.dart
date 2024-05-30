/*import 'package:campus_connect/services/constant.dart';
//import 'package:google_fonts/google_fonts.dart';
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
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '230',
      'comments': '12',
    },
    {
      'name': 'Chabain',
      'message':
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '192',
      'comments': '26',
    },
    {
      'name': 'Florent',
      'message':
          'Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein.',
      'picture': 'assets/theme3.png',
      'profil': 'assets/profil.jpeg',
      'date': '28 May 2024 at 10:02 AM',
      'like': '50',
      'comments': '56',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
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
                    width: 60,
                    height: 60,
                  ),
                ),
                IconButton(
                  icon: Icon(
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: publicationList.map((post) {
                return PublicationsCard(post);
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }
}

class PublicationsCard extends StatelessWidget {
  final Map publicationData;
  PublicationsCard(this.publicationData);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: Image.asset(
                    'assets/profil.jpeg',
                    fit: BoxFit.cover,
                    width: 45,
                    height: 45,
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  width: 200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            publicationData['name'],
                            style: TextStyle(
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
                            publicationData['date'],
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
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 330,
                  child: Text(
                    publicationData['message'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                      fontFamily: 'CrimsonText',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  publicationData['picture'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    'Events1',
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 1, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(Icons.thumb_up)),
                ),
                
                Text(
                  publicationData['name'],
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  publicationData['date'],
                  style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
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
*/