import 'dart:math' as math;
import 'package:campus_connect/models/message.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:campus_connect/views/widgets/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<Message> messages = [
    Message(
      text: 'yo ya la forme',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'tranquille',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 4)),
      isSendByMe: true,
    ),
    Message(
      text: 'et toi',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'posé',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 3)),
      isSendByMe: true,
    ),
    Message(
      text: 'tranquille',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'et toi',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
      isSendByMe: false,
    ),
    Message(
      text: 'posé',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
      isSendByMe: true,
    ),
    Message(
      text: 'posé',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 3)),
      isSendByMe: true,
    ),
    Message(
      text: 'tranquille',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 3)),
      isSendByMe: false,
    ),
    Message(
      text: 'et toi',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
      isSendByMe: false,
    ),
    Message(
      text: 'posé',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 4)),
      isSendByMe: true,
    ),
  ].reversed.toList();

  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 80),
                child: Row(
                  children: [
                    Container(
                      height: 75,
                      width: MediaQuery.of(context).size.width * 0.70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                'assets/profil.jpeg',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                  const Text(
                                    'Chabain',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const Text(
                                        'Online',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontFamily: 'CrimsonText',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GroupedListView<Message, DateTime>(
                  padding: const EdgeInsets.all(8),
                  reverse: true,
                  order: GroupedListOrder.DESC,
                  useStickyGroupSeparators: true,
                  floatingHeader: true,
                  elements: messages,
                  groupBy: (message) => DateTime(
                      message.date.year, message.date.month, message.date.day),
                  groupHeaderBuilder: (Message message) => SizedBox(
                    height: 40,
                    child: Center(
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            DateFormat.yMMMd().format(message.date),
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  itemBuilder: (context, Message message) => MessageBubble(
                    message: message,
                  ),
                ),
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
                          Icons.photo_camera_rounded,
                          color: campuscolor,
                        ),
                        onPressed: () {},
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'Enter your message here...',
                              hintStyle: TextStyle(fontSize: 16),
                              border: InputBorder
                                  .none, // Remove the line below hintText
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final text = _messageController.text;

                          if (text.isNotEmpty) {
                            final message = Message(
                              text: text,
                              date: DateTime.now(),
                              isSendByMe: true,
                            );

                            setState(() {
                              messages.add(message);
                              _messageController.clear();
                            });
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          ButtonBackWidget()
        ],
      ),
    );
  }
}
