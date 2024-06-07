import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  final String? text;
  final String? imageUrl;
  final DateTime date;
  final bool isSendByMe;

  Message({
    this.text,
    this.imageUrl,
    required this.date,
    required this.isSendByMe,
  });

  factory Message.fromDocument(DocumentSnapshot doc, String currentUser) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      text: data['text'],
      imageUrl: data['imageUrl'],
      date: (data['date'] as Timestamp).toDate(),
      isSendByMe: data['sendByMe'] == currentUser,
    );
  }
}
