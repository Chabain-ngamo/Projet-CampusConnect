import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class PublicationModel with ChangeNotifier {
  final String publicationId, userId, userName, message, publiPhoto, userPhoto;
  final int? nbLike, nbComment;
  final Timestamp publicationDate;

  PublicationModel(
      {required this.publicationId,
      required this.userId,
      required this.userName,
      required this.message,
      required this.publiPhoto,
      required this.userPhoto,
      required this.nbLike,
      required this.nbComment,
      required this.publicationDate});
}
