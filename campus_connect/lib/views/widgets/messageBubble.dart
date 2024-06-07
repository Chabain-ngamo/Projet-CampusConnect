import 'package:campus_connect/models/message.dart';
import 'package:campus_connect/services/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return message.isSendByMe
        ? ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 40, right: 8, top: 4, bottom: 4),
            backGroundColor: campuscolor,
            child: message.imageUrl != null
                ? Image.network(message.imageUrl!)
                : Text(
                    message.text!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
          )
        : ChatBubble(
            clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 8, right: 40, top: 4, bottom: 4),
            backGroundColor: const Color.fromARGB(42, 158, 158, 158),
            child: message.imageUrl != null
                ? Image.network(message.imageUrl!)
                : Text(
                    message.text!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                    ),
                  ),
          );
  }
}
