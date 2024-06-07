import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
      print(e.toString());
    });
  }

  Future<QuerySnapshot> getUserInfo(String email) async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .where("userEmail", isEqualTo: email)
          .get();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<QuerySnapshot> searchByName(String searchField) async {
    try {
      return await FirebaseFirestore.instance
          .collection("users")
          .where('userName', isEqualTo: searchField)
          .get();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> addChatRoom(Map<String, dynamic> chatRoom, String chatRoomId) async {
    try {
      await FirebaseFirestore.instance
          .collection("chatbetween")
          .doc(chatRoomId)
          .set(chatRoom);
      return true; // Retourner true si l'opération réussit
    } catch (e) {
      print(e);
      return false; // Retourner false si une exception est levée
    }
  }

  getChats(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection("chatbetween")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData)async {

    FirebaseFirestore.instance.collection("chatbetween")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
          print(e.toString());
    });
  }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatbetween")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

}
