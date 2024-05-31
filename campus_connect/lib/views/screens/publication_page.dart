import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:campus_connect/views/widgets/likesW.dart';
import 'package:flutter/material.dart';

class PublicationPage extends StatefulWidget {
  const PublicationPage({super.key});

  @override
  State<PublicationPage> createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> commentsList = [
      {
        'name': 'Duval',
        'comment':
            'pas mal labas comme initiative, elle a vraiment pou but de soutenir la femme pour la journée mondiale de lutte contre le cancer de sein',
        'profil': 'assets/profil.jpeg',
        'heure': '14:02',
      },
      {
        'name': 'Chabain',
        'comment':
            'pas mal labas comme initiative, elle a vraiment pou but de soutenir la femme pour la journée mondiale de lutte contre le cancer de sein',
        'profil': 'assets/profil.jpeg',
        'heure': '11:02',
      },
      {
        'name': 'Florent',
        'comment':
            'pas mal labas comme initiative, elle a vraiment pou but de soutenir la femme pour la journée mondiale de lutte contre le cancer de sein et dans cette initiative ils ont tous porter du rose',
        'profil': 'assets/profil.jpeg',
        'heure': '06:02',
      },
    ];

    return Scaffold(
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
                    child: Image.asset(
                      'assets/profil.jpeg',
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
                          children: const [
                            Text(
                              "Duval",
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
                          children: const [
                            Text(
                              "28 May 2024 at 10:02 AM",
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/theme3.png',
                  ),
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
              child: const Text(
                "Ensemble célébrons ce 19 octobre 2024 la journée mondiale de lutte contre le cancer de sein. A cet effet nous allons tous nous vêtir d’un vêtement rose.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'CrimsonText',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text(
                    "Comments",
                    style: TextStyle(
                      color: Colors.black,
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
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
                child: Column(
                  children: List.generate(commentsList.length, (index) {
                    return Column(
                      children: [
                        CommentCard(
                          commentData: commentsList[index],
                        ),
                        if (index < commentsList.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Divider(
                                color: Color.fromARGB(116, 158, 158, 158),
                                thickness: 1),
                          ),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
      ButtonBackWidget(),
      Positioned(
        bottom: 35,
        right: 20,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 55,
            width: 110,
            decoration: BoxDecoration(
              color: campuscolor,
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
                Text(
                '2.1K',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: 'CrimsonText',
                  fontWeight: FontWeight.w400,
                ),
              ),
              ],
            ),
          ),
        ),
      )
    ]));
  }
}

class CommentCard extends StatelessWidget {
  final Map<String, String> commentData;

  CommentCard({
    required this.commentData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        child: Image.asset(
          commentData['profil']!,
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
              commentData['name']!,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              commentData['heure']!,
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
                commentData['comment']!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'CrimsonText',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Positioned(right: 1, bottom: 1, child: LikeButton())
        ],
      ),
    );
  }
}
