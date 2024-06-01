import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/publication_page.dart';
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
  Widget build(BuildContext context) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => PublicationPage()))
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        height: 385,
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
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      child: Image.asset(
                        'assets/profil.jpeg',
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
                                publicationData['name'],
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
                                publicationData['date'],
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
                        publicationData['message'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
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
                    Text(
                      publicationData['like'],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: campuscolor),
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
                    Text(
                      publicationData['comments'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
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
                  children: const [
                    Text(
                      '28',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Text(
                      'May',
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
