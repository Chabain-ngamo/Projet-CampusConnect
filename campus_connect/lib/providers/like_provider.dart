import 'package:campus_connect/models/likeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LikeProvider with ChangeNotifier {
  Map<String, LikeModel> _likeItems = {};

  Map<String, LikeModel> get getLikeItems {
    return _likeItems;
  }

  final userCollection = FirebaseFirestore.instance.collection('users');
  final publicationCollection =
      FirebaseFirestore.instance.collection('publications');

  Future<void> fetchLikelist() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }

    final List<dynamic> userLikes = userDoc.get('userLike');
    final int leng = userLikes.length;

    for (int i = 0; i < leng; i++) {
      final String publicationId = userLikes[i]['publicationId'];

      _likeItems.putIfAbsent(
        publicationId,
        () => LikeModel(
          id: userLikes[i]['likeId'],
          publicationId: publicationId,
        ),
      );

      // Incrémenter nbLikes dans la collection publications
      try {
        await publicationCollection.doc(publicationId).update({
          'nbLike': FieldValue.increment(1),
        });
      } catch (e) {
        // Gérer l'erreur, par exemple en affichant un message à l'utilisateur
        print('Erreur lors de l\'incrémentation de nbLikes: $e');
      }
    }

    notifyListeners();
  }

  Future<void> removeOneItem({
    required String likeId,
    required String publicationId,
  }) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // Supprimer le like de l'utilisateur
    await userCollection.doc(user.uid).update({
      'userLike': FieldValue.arrayRemove([
        {
          'likeId': likeId,
          'publicationId': publicationId,
        }
      ])
    });

    _likeItems.remove(publicationId);

    // Décrémenter nbLikes dans la collection publications
    try {
      await publicationCollection.doc(publicationId).update({
        'nbLike': FieldValue.increment(-1),
      });
    } catch (e) {
      // Gérer l'erreur, par exemple en affichant un message à l'utilisateur
      print('Erreur lors de la décrémentation de nbLikes: $e');
    }

    // Recharger la liste des likes
    await fetchLikelist();
    notifyListeners();
  }
}
