import 'package:campus_connect/models/pulicationModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';


class PublicationProvider with ChangeNotifier {
  static List<PublicationModel> _publication = [];
  List<PublicationModel> get getPublication {
    return _publication;
  }

  Future<void> fetchPublication() async {
    await FirebaseFirestore.instance
        .collection('publications')
        .get()
        .then((QuerySnapshot publiSnapshot) {
      _publication = [];
      // _publication.clear();
      publiSnapshot.docs.forEach((element) {
        _publication.insert(
          0,
          PublicationModel(
            publicationId: element.get('publicationId'),
            userId: element.get('userId'),
            userName: element.get('userName'),
            message: element.get('message'),
            publiPhoto: element.get('publiPhoto'),
            userPhoto: element.get('userPhoto'),
            nbLike: (element.get('nbLike') ?? 0).toInt(), 
            nbComment: (element.get('nbComment') ?? 0).toInt(),
            publicationDate: element.get('publicationDate'),
          ),
        );
      });
    });
    notifyListeners();
  }


  PublicationModel findPubById(String publicationId) {
    return _publication.firstWhere((element) => element.publicationId == publicationId);
  }


}
