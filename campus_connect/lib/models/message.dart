import 'package:flutter/material.dart';

class Message {
  final String text;
  final DateTime date;
  final bool isSendByMe;

  Message({
    required this.text,
    required this.date,
    required this.isSendByMe,
  });
}