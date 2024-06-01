import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/chat_detail_page.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List publicationList = [
    {
      'name': 'Duval',
      'promotion': 'X2025',
      'profil': 'assets/profil.jpeg',
      'publications': '26',
      'like': '230',
      'comments': '12',
    },
    {
      'name': 'Florent',
      'promotion': 'X2025',
      'profil': 'assets/profil.jpeg',
      'publications': '23',
      'like': '300',
      'comments': '6',
    },
    {
      'name': 'Yves',
      'promotion': 'X2025',
      'profil': 'assets/profil.jpeg',
      'publications': '14',
      'like': '146',
      'comments': '14',
    },
    {
      'name': 'Chabain',
      'promotion': 'X2025',
      'profil': 'assets/profil.jpeg',
      'publications': '26',
      'like': '230',
      'comments': '25',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(59, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (valuee) {},
                        decoration: const InputDecoration(
                          hintText: 'What profile are you looking for?',
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontFamily: 'CrimsonText',
                              color: Colors.grey),
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel_rounded,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: publicationList.map((post) {
                return SearchCard(post);
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }
}

class SearchCard extends StatelessWidget {
  final Map publicationData;
  SearchCard(this.publicationData);
  @override
  Widget build(BuildContext context) {
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
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: Image.asset(
                      'assets/profil.jpeg',
                      fit: BoxFit.cover,
                      width: 65,
                      height: 65,
                    ),
                  ),
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
                                      publicationData['publications'],
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
                                      publicationData['like'],
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
                                      publicationData['comments'],
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
                              padding: const EdgeInsets.only(top: 10,left: 20),
                              child: SizedBox(
                                height: 35,
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) => ChatDetailPage()))
                                    );
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
              margin: const EdgeInsets.only(left: 10,),
              child: Row(
                children: [
                  Text(
                    publicationData['name'],
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
              margin: const EdgeInsets.symmetric(horizontal: 10,),
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
                    publicationData['promotion'],
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
