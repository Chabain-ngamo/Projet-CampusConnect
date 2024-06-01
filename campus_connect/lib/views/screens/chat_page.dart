import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/screens/chat_detail_page.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> interlocuteurList = [
      {
        'name': 'Duval',
        'message': 'pas mal labas ',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '02',
        'heure': '10:30',
      },
      {
        'name': 'Chabian',
        'message': 'posé dans le bendo',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '01',
        'heure': '06:30',
      },
      {
        'name': 'Tankiste',
        'message': 'lol',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '13',
        'heure': '15:30',
      },
      {
        'name': 'Ghislain',
        'message': 'yeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '02',
        'heure': '10:30',
      },
      {
        'name': 'Darryl',
        'message': 'je ris dans l eau glou glou glou',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '01',
        'heure': '10:30',
      },
      {
        'name': 'chaubo',
        'message': 'tu fais à qui',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '01',
        'heure': '10:30',
      },
      {
        'name': 'Axcel',
        'message': 'arrete ca ',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '01',
        'heure': '10:30',
      },
      {
        'name': 'Yves',
        'message': 'zanzibarrrr',
        'profil': 'assets/profil.jpeg',
        'nbMessage': '01',
        'heure': '14:30',
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: const [
                  Text(
                    "Chat",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
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
                child: Column(
                  children: List.generate(interlocuteurList.length, (index) {
                    return Column(
                      children: [
                        InterlocuteurCard(
                          InterlocuteurData: interlocuteurList[index],
                        ),
                        if (index < interlocuteurList.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
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
    ]));
  }
}

class InterlocuteurCard extends StatelessWidget {
  final Map<String, String> InterlocuteurData;

  InterlocuteurCard({
    required this.InterlocuteurData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => const ChatDetailPage()))
        );
      },
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          child: Image.asset(
            InterlocuteurData['profil']!,
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
                InterlocuteurData['name']!,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                InterlocuteurData['heure']!,
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
                  InterlocuteurData['message']!.length > 20
                      ? '${InterlocuteurData['message']!.substring(0, 20)}...'
                      : InterlocuteurData['message']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'CrimsonText',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
