import 'dart:async';
import 'dart:math' as math;
import 'package:campus_connect/models/message.dart';
import 'package:campus_connect/providers/dark_theme_provider.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:campus_connect/views/widgets/back_button.dart';
import 'package:campus_connect/views/widgets/messageBubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  final String chatId;
  final String otherUserName;
  final String otherUserPhotoUrl;
  const ChatDetailPage({
    super.key,
    required this.chatId,
    required this.otherUserName,
    required this.otherUserPhotoUrl,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _messagesSubscription;
  String? _currentUser;


  List<Message> messages = [];
  TextEditingController _messageController = TextEditingController();



 @override
void initState() {
  super.initState();
  _currentUser = _auth.currentUser?.uid;
  _messagesSubscription = _firestore
    .collection('messages')
    .doc(widget.chatId)
    .collection('chat')
    .orderBy('date', descending: false)
    .snapshots()
    .listen((snapshot) {
      if (mounted) {
        setState(() {
          messages = snapshot.docs
            .map((doc) => Message(
                  text: doc.data()['text'],
                  date: (doc.data()['date'] as Timestamp).toDate(),
                  isSendByMe: doc.data()['sendByMe'] == _currentUser,
                ))
            .toList();
        });
      }
    });
}



@override
void dispose() {
  _messagesSubscription.cancel();
  super.dispose();
}


Future<void> _loadMessages() async {
  if (!mounted) return; // Vérifier si le widget est encore monté

  final snapshot = await _firestore
      .collection('messages')
      .doc(widget.chatId)
      .collection('chat')
      .orderBy('date', descending: true)
      .get();

  setState(() {
    messages = snapshot.docs
        .map((doc) => Message(
              text: doc.data()['text'],
              date: (doc.data()['date'] as Timestamp).toDate(),
              isSendByMe: doc.data()['sendByMe'],
            ))
        .toList();
  });
}

Future<void> _sendMessage() async {
  final text = _messageController.text;
  if (text.isNotEmpty) {
    final message = Message(
      text: text,
      date: DateTime.now(),
      isSendByMe: true,
    );

    await _firestore
      .collection('messages')
      .doc(widget.chatId)
      .collection('chat')
      .add({
        'text': message.text,
        'date': message.date,
        'sendByMe': _currentUser,
      });

    _messageController.clear();
  }
}




  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    final Color colorB =
        themeState.getDarkTheme ? Color(0xFF1A1B20) : Colors.white;

    return Scaffold(
      backgroundColor: colorB,
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
                        color: colorB,
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
                              child: 
                              Image(
                                image: CachedNetworkImageProvider(
                                  widget.otherUserPhotoUrl,
                                ),
                                fit: BoxFit.cover,
                                width: 60,
                                height: 60,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                children: [
                                   Text(
                                    widget.otherUserName,
                                    style: TextStyle(
                                      color: color,
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
                        onPressed:  _sendMessage,
                        /*() async {
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
                        },*/
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
